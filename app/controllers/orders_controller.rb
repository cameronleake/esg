class OrdersController < ApplicationController


  def review
    @cart = current_shopping_cart
    @cart_items = @cart.resources
    @total_cost = @cart.total_cart_cost/100
  end    
        
    
  def payment_redirect
    @payment_method = params[:payment_method]
    if @payment_method == "credit_card"
      redirect_to new_order_path
    elsif @payment_method == "express"
      redirect_to express_path
    else
      flash[:error] = "Please select a payment type."
      render :action => "review"
    end      
  end


  def express
    @cart_total_in_cents = current_shopping_cart.total_cart_cost 
    response = EXPRESS_GATEWAY.setup_purchase(@cart_total_in_cents,
      :ip                => request.remote_ip,
      :return_url        => new_order_url,
      :cancel_return_url => shopping_cart_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
         

  def new
    @cart = current_shopping_cart       
    @cart_items = @cart.resources
    @total_cost = @cart.total_cart_cost/100     
    if params[:token]     # PayPal Express Payment
      @order = Order.new(:express_token => params[:token])
      @order.save!    
    elsif @cart.order     # Existing Order for the Cart
      @order = @cart.order
    else                  # Create New Order
      @order = Order.new    
    end
    @cart.order = @order
    @cart.save!
  end

                    
  def update
    # Get the current Cart and Order 
    @cart = current_shopping_cart
    @order = @cart.order         
    @order.ip_address = request.remote_ip        
    
    # If this is a Standard Order
    if params[:order] 
      @order.update_attributes(params[:order])
    end    
    
    # Perform purchase on the Order
    if @order.save
      if @order.purchase(@cart) 
        @order.generate_download_links
        if @order.delay.send_download_links_email
          @order.email_sent = true
        end
        @order.status = "Payment Confirmed"
        if @order.express_token
          @order.payment_method = "PayPal Express"
        else
          @order.payment_method = "Standard"
        end
        @cart.status = "Closed" 
        @order.save! 
        @cart.save!
        cookies.delete(:cart_token)  
        redirect_to order_completed_path, :notice => "Order processed successfully!"
      else             
        @order.status = "Error"
        @cart.status = "Error"
        @order.save!        
        @cart.save!
        flash[:error] = "#{@order.transactions.last.message}"
        render :action => "failure"
      end             
    else 
      flash[:error] = "Please fill in all required fields."
      render :action => 'new'
    end
  end  
  
  
  def free_order 
    @cart = current_shopping_cart
    if @cart.order
      @order = @cart.order
    else
      @order = Order.new
    end
    @order.email = params[:email]    
    @order.ip_address = request.remote_ip    
    
    @order.generate_download_links
    if @order.delay.send_download_links_email
      @order.email_sent = true
    end                    
    @order.payment_method = "Free - No Charge"
    @cart.status = "Closed"
    @order.save! 
    @cart.order = @order     
    @cart.save!
    cookies.delete(:cart_token)  
    redirect_to order_completed_path, :notice => "Order processed successfully!"
  end              
  
end

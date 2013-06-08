class OrdersController < ApplicationController


  def review
    @total_cost = current_shopping_cart.total_cart_cost     
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
    
    # If this is a Standard Order, update it
    if params[:order]         
      @order.update_attributes(params[:order])
      @order.save!
    end    
    
    # Perform purchase on the Order
    if @order.purchase(@cart) 
      @order.generate_download_links
      if @order.delay.send_download_links_email
        @order.email_sent = true
      end
      @order.status = "Payment Confirmed"
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
  end                    
  
end

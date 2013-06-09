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

    ###### <TODO> FIX THIS!  Needs to take the Order object for the current Shopping Cart and update with the params, if applicable.

    # @order = Order.find(@cart.order_id)
    # if params[:token]         
    #   @order.destroy
    #   @new_order = Order.new(:express_token => params[:token], :shopping_cart_id => @cart.id)
    #   @cart.order_id = @new_order.id
    #   @new_order.save(:validate => false)
    #   @cart.save
    #   @order = @new_order
    # end 
  end

                    
  def update
    @cart = current_shopping_cart
    @order = @cart.order         
    @order.ip_address = request.remote_ip        
    if params[:order] 
      @order.update_attributes(params[:order])
    end    
    if @order.express_token
      @order.payment_method = "PayPal Express"
      unless @order.save(:validate => false)
        flash[:error] = "Error with PayPal Express Gateway."
        render :action => 'new'
      end
    else
      @order.payment_method = "Standard"
      unless @order.save
        flash[:error] = "Please fill in all required fields."
        render :action => 'new'
      end
    end
    
    if @order.purchase(@cart) 
      @order.generate_download_links
      if @order.delay.send_download_links_email
        @order.email_sent = true
      end
      @order.status = "Payment Confirmed"
      @cart.status = "Closed" 
      @order.save
      @cart.save
      cookies.delete(:cart_token)  
      redirect_to order_completed_path, :notice => "Order processed successfully!"
    else             
      @order.status = "Error"      # <TODO> This needs to handle better for user.
      @cart.status = "Error"
      @order.save       
      @cart.save
      flash[:error] = "#{@order.transactions.last.message}"
      render :action => "failure"
    end             
  end  
  
  
  def free_order 
    @cart = current_shopping_cart
    @order = @cart.order
    @order.email = params[:email]
    @order.ip_address = request.remote_ip
    @order.payment_method = "Free"
    @order.status = "Closed"
        
    @order.generate_download_links
    if @order.delay.send_download_links_email
      @order.email_sent = true
    end                            
    
    @cart.status = "Closed"  
    @cart.order = @order
    @order.save(:validate => false) 
    @cart.save
    cookies.delete(:cart_token)  
    redirect_to order_completed_path, :notice => "Order processed successfully!"    
  end              
  
end

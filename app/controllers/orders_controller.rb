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
    @user = current_user
    @cart = current_shopping_cart
    @total_cost = @cart.total_cart_cost/100     
    @order = @cart.order   
    if params[:token]
      @order.update_attributes(:express_token => params[:token])
      @order.save!(:validate => false)
    end                 
    @order.street1 = @user.street1           # <TODO> Refactor and move into model.
    @order.street2 = @user.street2
    @order.city = @user.city
    @order.state = @user.state
    @order.country = @user.country
    @order.zip = @user.zip
  end

                    
  def update
    @user = current_user
    @cart = current_shopping_cart
    @order = @cart.order         
    @order.ip_address = request.remote_ip        
    if params[:order] 
      @order.update_attributes(params[:order])
    end    
    if @order.express_token
      @order.payment_method = "PayPal Express"
      unless @order.save!(:validate => false)
        flash[:error] = "Error with PayPal Express Gateway."
        render :action => 'new'
      end
    else
      @order.payment_method = "Standard"
      if @order.valid?
        @order.save!
        @user.save_address(@order)
        
        if @order.purchase(@cart) 
          @order.generate_download_links
          if @order.delay.send_download_links_email
            @order.email_sent = true
          end
          @order.status = "Payment Confirmed"
          @cart.status = "Closed" 
          @order.save!(:validate => false)
          @cart.save!
          cookies.delete(:cart_token)  
          redirect_to order_completed_path, :notice => "Order processed successfully!"
        else             
          @order.status = "Error"
          @cart.status = "Error"
          @order.save!(:validate => false) 
          @cart.save! 
          
          case @order.transactions.last.error_codes
          when 10527
            flash[:error] = "Please enter a valid credit card number & type"
            render :action => 'new'    
          when 10508
            flash[:error] = "Please enter a valid credit card expiration date"
            render :action => 'new'            
          else
            flash[:error] = "#{@order.transactions.last.message}"
            render :action => "failure"            
          end            

        end
      else
        flash[:error] = "Please fill in all required fields."
        render :action => 'new'
      end
    end     
  end    
  
  
  def failure
    @cart = current_shopping_cart
    @order = @cart.order
    @last_transaction = @order.transactions.last
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
    @order.save!(:validate => false) 
    @cart.save!
    cookies.delete(:cart_token)  
    redirect_to order_completed_path, :notice => "Order processed successfully!"    
  end              
  
end

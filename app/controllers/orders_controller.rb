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
    end      
    # xxx   
  end


  def express
    response = EXPRESS_GATEWAY.setup_purchase(current_shopping_cart.build_order.price_in_cents,
      :ip                => request.remote_ip,
      :return_url        => new_order_url,
      :cancel_return_url => shopping_cart_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
         

  def new
    @order = Order.new(:express_token => params[:token])  
    @cart = current_shopping_cart
    @cart_items = @cart.resources
    @total_cost = @cart.total_cart_cost/100         
  end

                    
  def create
    @cart = current_shopping_cart
    @order = @cart.build_order(params[:order]) 
    if @order.save
      if @order.purchase(@cart)
        redirect_to order_completed_path, :notice => "Order processed successfully!"
      else
        flash[:error] = "#{@order.transactions.last.message}"
        render :action => "failure"
      end
    else
      flash[:error] = @order.errors.full_messages.join(' | ')
      render :action => 'new'      
    end                        
  end                    

  
                                                                     
  def process_order                               
    @order = Order.find(cookies[:order_id])    
    @cart = current_shopping_cart   
    if @order.purchase(@cart)
      @cart.generate_download_links
      if @cart.delay.send_download_links_email
        @cart.email_sent = true
      end
      @cart.save!
      cookies.delete(:order_id)
      cookies.delete(:cart_token)       
      redirect_to order_completed_path, :notice => "Order processed successfully!"  
    else
      flash[:error] = "#{@order.transactions.last.message} #{@order.card_number} #{@order.card_verification}"
      render :action => "failure"
    end
  end   
  
end

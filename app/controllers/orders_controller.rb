class OrdersController < ApplicationController
       

  def new
    @order = Order.new(:express_token => params[:token])
    @cart = current_shopping_cart
    @cart_items = @cart.resources
    @total_cost = @cart.total_cart_cost/100         
  end


  def express
    response = EXPRESS_GATEWAY.setup_purchase(current_shopping_cart.build_order.price_in_cents,
      :ip                => request.remote_ip,
      :return_url        => review_order_url,
      :cancel_return_url => shopping_cart_url
    )
    redirect_to EXPRESS_GATEWAY.redirect_url_for(response.token)
  end
  
  
  def create    
    @order = current_shopping_cart.build_order(params[:order])    
    @order.status = "New"     
    @order.ip_address = request.remote_ip   
    if @order.save!
      cookies[:order_id] = @order.id
      redirect_to review_order_path
    else
      flash[:error] = @order.errors.full_messages.join(' | ')
      render :action => 'new'
    end 
  end                    
        
  
  def review   
    if params[:token]
      @order = Order.new(:express_token => params[:token])       
      @order.status = "New"
      @order.ip_address = request.remote_ip   
      if @order.save!
        cookies[:order_id] = @order.id 
        @payment_type = "PayPal Express Payment"
        @total_cost = current_shopping_cart.total_cart_cost    
      else   
        xxx  # <TODO> Put something useful here.        
      end
    else       
      @order = Order.find(cookies[:order_id])
      @payment_type = "Standard Payment"     
      @total_cost = current_shopping_cart.total_cart_cost
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
      redirect_to order_completed_path, :notice => "Order Processed.  You will recieve an email with your download links shortly!" 
    else
      flash[:error] = "#{@order.transactions.last.message} #{@order.card_number} #{@order.card_verification}"
      render :action => "failure"
    end
  end   
  
end

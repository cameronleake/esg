class OrdersController < ApplicationController


  def express
    response = EXPRESS_GATEWAY.setup_purchase(current_shopping_cart.build_order.price_in_cents,
      :ip                => request.remote_ip,
      :return_url        => review_order_url,
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
  
  
  def review
    @order = Order.new(:express_token => params[:token])
  end


  # This method processes payments via the Credit Card Input Form
  def create
    @cart = current_shopping_cart
    @cart_items = @cart.resources
    @total_cost = @cart.total_cart_cost/100
    @order = Order.new(:express_token => params[:token])   
    @order.ip_address = request.remote_ip      
    if @order.save
      if @order.purchase
        redirect_to order_completed_path, :notice => "Order Processed.  You will recieve an email with your download links shortly!" 
      else
        flash[:error] = @order.transactions.last.message
        render :action => "failure"
      end
    else
      flash[:error] = @order.errors.full_messages.join(' | ')
      render :action => 'new'
    end
  end                    
  
           
  # This method processes payments via the PayPal Express Checkout
  def process_order
    @order = Order.new(:express_token => params[:token])   
    @order.ip_address = request.remote_ip      
    if @order.save
      if @order.purchase
        redirect_to order_completed_path, :notice => "Order Processed.  You will recieve an email with your download links shortly!" 
      else
        flash[:error] = @order.transactions.last.message
        render :action => "failure"
      end
    else
      flash[:error] = @order.errors.full_messages.join(' | ')
      render :action => 'new'
    end 
  end
  
  
  def completed
    # <TODO>
  end
  
  
  def process_cart    # <TODO> Depricated Method.
    @user = current_user
    @cart = current_shopping_cart
    # # ---------- Process Payments Here ----------
    # if # Payment is verified
    #   @cart.payment_verified = true
    # end
    @cart.generate_download_links
    if @cart.delay.send_download_links_email
      @cart.email_sent = true
    end
    @cart.save!
    cookies.delete(:cart_token)
    redirect_to root_path, :notice => "Order Processed.  You will recieve an email with your download links shortly!"
  end
  
end

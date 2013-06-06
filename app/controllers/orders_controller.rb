class OrdersController < ApplicationController
  
  def new
    @order = Order.new
    @cart = current_shopping_cart
    @cart_items = @cart.resources
    @total_cost = @cart.total_cart_cost/100
  end
  
  
  def create
    @order = current_shopping_cart.build_order(params[:order])
    @order.ip_address = request.remote_ip
    if @order.save
      xxx   # <TODO>
    else
      render :action => 'new'
    end
  end
  
  
  def process_cart    # <TODO> Implement this.
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

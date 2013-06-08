class OrderMailer < ActionMailer::Base
  default from: "noreply@engineeringsurvivalguide.com"

  def download_links_email(order)
    @order = order
    @cart = order.shopping_cart
    mail :to => @cart.user.email, :subject => "Order Number: #{@order.order_number}"
  end

end  

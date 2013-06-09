class OrderMailer < ActionMailer::Base
  default from: "noreply@engineeringsurvivalguide.com"

  def download_links_email(order)
    @order = order
    @cart = order.shopping_cart
    mail :to => @order.email, :subject => "Order Number: #{@order.order_number}"
  end

end  

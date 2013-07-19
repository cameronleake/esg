class OrderMailer < ActionMailer::Base
  default from: "noreply@engineeringsurvivalguide.com"

  def order_receipt(order)
    @order = order
    @cart = order.shopping_cart
    mail :to => @order.email, :subject => "Order Number: #{@order.order_number}"
  end

end  

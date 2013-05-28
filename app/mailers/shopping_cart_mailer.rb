class ShoppingCartMailer < ActionMailer::Base
  default from: "noreply@engineeringsurvivalguide.com"

  def download_links_email(cart)
    @cart = cart
    mail :to => cart.user.email, :subject => "Order Number: #{cart.order_number}"
  end
  
end

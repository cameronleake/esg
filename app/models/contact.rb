class Contact < ActiveRecord::Base
  attr_accessible :name, :email, :subject, :body
  validates_presence_of :name, :email, :subject, :body, :on => :create
  
  def send_contact_form
    ContactMailer.contact_us(self).deliver
  end
  
end

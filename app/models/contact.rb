class Contact < ActiveRecord::Base
  include Rakismet::Model
  attr_accessible :topic, :name, :email, :subject, :body, :spam, :status
  validates_presence_of :topic, :name, :email, :subject, :body, :on => :create
  rakismet_attrs  :author => proc { :email },
                  :author_email => proc { :email },
                  :content => proc { :body }
  
  
  def send_contact_form
    ContactMailer.contact_us(self).deliver
  end  
  
 
  def send_contact_notification
    ContactMailer.contact_notification(self).deliver
  end      
  
end
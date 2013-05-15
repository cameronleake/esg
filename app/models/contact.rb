class Contact < ActiveRecord::Base
  include Rakismet::Model
  
  attr_accessible :name, :email, :subject, :body
  validates_presence_of :name, :email, :subject, :body, :on => :create
  rakismet_attrs  :author => proc { :email },
                  :author_email => proc { :email },
                  :content => proc { :body }
  
  def send_contact_form
    ContactMailer.contact_us(self).deliver
  end
  
end
class User < ActiveRecord::Base
  has_secure_password
  mount_uploader :avatar, AvatarUploader
  attr_accessible :first_name
  attr_accessible :last_name
  attr_accessible :email
  attr_accessible :password
  attr_accessible :password_confirmation
  attr_accessible :email_verified
  attr_accessible :email_verification_token
  attr_accessible :blog_subscription
  attr_accessible :resources_subscription
  attr_accessible :avatar
  attr_writer :password_required
  validates_presence_of :first_name, :last_name, :email
  validates_presence_of :password, :on => :create
  validates_presence_of :password, :on => :update, :if => Proc.new { |m| m.password_required == true }
  validates_uniqueness_of :email
  validates :email, format: {
    with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  }
  before_create { generate_token(:auth_token) }
  has_many :blog_comments, :dependent => :destroy
  has_many :resources
  has_many :downloads, :through => :shopping_carts
  has_many :reviews, :dependent => :destroy
  has_many :shopping_carts, :dependent => :destroy
    
    
  def password_required
    @password_required || false
  end
     
    
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = DateTime.now
    self.save!
    UserMailer.password_reset(self).deliver
  end
  
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
      
  
  def send_welcome_email
    UserMailer.welcome_message(self).deliver
  end
        
  
  def send_verification_email
    UserMailer.email_verification_message(self).deliver
  end
      
  
  def get_user_email
    email
  end
        
  
  def get_downloads_list
    @downloads = []
    self.shopping_carts.each do |cart|
      cart.downloads.each do |download|
        @downloads << download
      end  
    end     
    return @downloads
  end
       
  
  def un_verify_email
    self.email_verified = false
    self.save!
  end    
  
  
  def save_address(order) 
    @order = order
    self.street1 = @order.street1
    self.street2 = @order.street2
    self.city = @order.city
    self.state = @order.state
    self.country = @order.country
    self.zip = @order.zip
    self.save!
  end
  
end

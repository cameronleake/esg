class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :password, :password_confirmation, :email_verified, :email_verification_token
  attr_writer :password_required
  validates_presence_of :password, :on => :create
  validates_presence_of :password, :on => :update, :if => Proc.new { |m| m.password_required == true }
  validates_presence_of :email
  validates :email, format: {
    with: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
  }
  validates_uniqueness_of :email
  before_create { generate_token(:auth_token) }
  
  def password_required
    @password_required || false
  end
    
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
    def generate_random_token
     SecureRandom.urlsafe_base64
  end
    
  def send_welcome_email
    UserMailer.welcome_message(self).deliver
  end
  
  def send_verification_email
    UserMailer.email_verification_message(self).deliver
  end
  
end

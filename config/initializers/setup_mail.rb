require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.mandrillapp.com",
  :port                 => 587,
  :domain               => "engineeringsurvivalguide.com", 
  :user_name            => "cameronleake7@gmail.com", 
  :password             => "OXULi_m29JHaU8pME2-VlQ",
  :authentication       => :login,
  :enable_starttls_auto => true
}

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
  :address              => "webcloud45.au.syrahost.com",
  :port                 => 465,
  :domain               => "engineeringsurvivalguide.com", 
  :user_name            => "noreply@engineeringsurvivalguide.com", 
  :password             => "survive99",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
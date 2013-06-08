require 'development_mail_interceptor'

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "gmail.com",                   # "engineeringsurvivalguide.com",           <TODO>
  :user_name            => "cameronleake7@gmail.com",     # "noreply@engineeringsurvivalguide.com",
  :password             => "billabong83",                 # "survive99",
  :authentication       => "plain",
  :enable_starttls_auto => true
}

ActionMailer::Base.register_interceptor(DevelopmentMailInterceptor) if Rails.env.development?
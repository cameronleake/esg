class DevelopmentMailInterceptor
  def self.delivering_email(message)
    message.subject = "#{message.to} #{message.subject}"
    # message.to = "development@engineeringsurvivalguide.com"
    message.to = "cameronleake7@gmail.com"
  end
end
class ContactMailer < ActionMailer::Base

  def contact_us(contact)
    @contact = contact  
    mail(:to => "helpdesk@engineeringsurvivalguide.com", :subject => "Contact Us Form: #{@contact.subject}", :from => "noreply@engineeringsurvivalguide.com")
  end

end

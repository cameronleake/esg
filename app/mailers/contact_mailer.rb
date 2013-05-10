class ContactMailer < ActionMailer::Base

  def contact_us(contact)
    @contact = contact
    attachments.inline["Email_Header-ESG.jpg"] = File.read("#{Rails.root}/app/assets/images/Email_Header-ESG.jpg")    
    mail(:to => "helpdesk@engineeringsurvivalguide.com", :subject => "Contact Us Form: #{@contact.subject}", :from => "noreply@engineeringsurvivalguide.com")
  end

end

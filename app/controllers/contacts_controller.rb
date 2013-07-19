class ContactsController < ApplicationController
  
  def new   
    @contact = Contact.new
    @contact.status = "OPEN"
  end
  
  def create
    @contact = Contact.new(params[:contact])
    if @contact.spam?
      @contact.spam = true && @contact.save!
      redirect_to contact_path, alert: "Sorry, this message has been marked as spam!"
    elsif @contact.save
      # @contact.delay.send_contact_form      # <TODO>
      @contact.send_contact_form    
      redirect_to root_path, notice: "Form submitted!"
    else
      flash.now.alert = "Please fill in all fields."
      render action: "new"
    end
  end
end

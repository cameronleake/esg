class ContactsController < ApplicationController
  
  def new
    @contact = Contact.new
  end
  
  def create
    @contact = Contact.new(params[:contact])
    if @contact.save
      @contact.delay.send_contact_form      
      redirect_to root_path, notice: "Form submitted!"
    else
      flash.now.alert = "Please fill in all fields."
      render action: "new"
    end
  end
end

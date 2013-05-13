require 'spec_helper'

describe "CONTROLLER >> ContactsController:" do
  context "When submitting a new Contact Us form:" do
    it "Should save all fields in the CONTACTS table" do
      @contact = FactoryGirl.build(:contact)
      visit contact_path
      fill_in "Name", :with => @contact.name
      fill_in "Email", :with => @contact.email
      fill_in "Subject", :with => @contact.subject
      fill_in "Message", :with => @contact.body
      click_button "Submit"
      current_path.should eq(root_path)
      Contact.find(:last).name.should eq(@contact.name)
      Contact.find(:last).email.should eq(@contact.email)
      Contact.find(:last).subject.should eq(@contact.subject)
      Contact.find(:last).body.should eq(@contact.body)          
    end    
    
    it "Email should be sent with form details" do
      @contact = FactoryGirl.build(:contact)
      visit contact_path
      fill_in "Name", :with => @contact.name
      fill_in "Email", :with => @contact.email
      fill_in "Subject", :with => @contact.subject
      fill_in "Message", :with => @contact.body
      click_button "Submit"
      last_email.to.should include("helpdesk@engineeringsurvivalguide.com")
      last_email.subject.should include(@contact.subject)  
    end
  end
end
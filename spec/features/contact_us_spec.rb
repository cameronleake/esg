require 'spec_helper'
require 'helpers/contact_us_helper_spec'

describe "CONTACT US FORM:" do
  context "When submitting a new Contact Us form:" do
    it "Should save all fields in the CONTACTS table" do
      @contact = FactoryGirl.build(:contact)
      submit_contact_us_form(@contact.name, @contact.email, @contact.subject, @contact.body)
      current_path.should eq(root_path)
      Contact.find(:last).should be_true        
    end    
    
    it "Email should be sent with form details" do
      @contact = FactoryGirl.build(:contact)
      submit_contact_us_form(@contact.name, @contact.email, @contact.subject, @contact.body)
      last_email.should be_true
      last_email.to.should include("helpdesk@engineeringsurvivalguide.com")
      last_email.subject.should include(@contact.subject)  
    end
  end
end
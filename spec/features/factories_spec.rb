require 'spec_helper'

describe "FACTORIES:" do
  context "USER Factory:" do
    it "Creates new user from USER factory" do
      user = FactoryGirl.build(:user)
    end

    it "Creates multiple, unique users from USER factory" do
      user1 = FactoryGirl.build(:user)
      user2 = FactoryGirl.build(:user)
      user3 = FactoryGirl.build(:user)
      assert_not_equal user1.email, user2.email, user3.email
    end

    it "Should create a User in the Test Database" do
      @user = FactoryGirl.create(:user)
      User.find(:last).should_not be_nil
    end
  
    it "Should not create a User in the Test Database" do
      @user = FactoryGirl.build(:user)
      User.find(:last).should be_nil
    end
  end
  
  context "CONTACT Factory:" do
    it "Should create a CONTACT with all fields in the CONTACTS table" do
      @contact = FactoryGirl.create(:contact)
      Contact.find(:last).name.should eq(@contact.name)
      Contact.find(:last).email.should eq(@contact.email)
      Contact.find(:last).subject.should eq(@contact.subject)
      Contact.find(:last).body.should eq(@contact.body)
    end
  end
end
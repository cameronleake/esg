require "spec_helper"

describe "MAILER >> user_mailer:" do
  context "MODEL > password_reset:" do
    let(:user) { FactoryGirl.build(:user, :password_reset_token => "anything" ) }
    let(:mail) { UserMailer.password_reset(user) }

    it "Sends user password reset url" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq([user.email])
      mail.from.should eq(["noreply@engineeringsurvivalguide.com"])
      mail.body.encoded.should match(edit_password_reset_path(user.password_reset_token))
    end
  end
end

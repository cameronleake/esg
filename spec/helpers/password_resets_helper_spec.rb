require 'spec_helper'

def reset_email_address(email)
  visit login_path
  click_link "Reset"
  fill_in "Email", :with => email
  click_button "Reset"
end
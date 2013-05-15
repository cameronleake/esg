require 'spec_helper'

def signup_new_user(first, last, email, password)
  visit signup_path
  fill_in "user_first_name", :with => first
  fill_in "user_last_name", :with => last
  fill_in "user_email", :with => email
  fill_in "user_password", :with => password
  fill_in "user_password_confirmation", :with => password
  click_button "Sign Up"
end
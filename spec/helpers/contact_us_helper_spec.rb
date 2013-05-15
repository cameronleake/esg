require 'spec_helper'

def submit_contact_us_form(name, email, subject, body)
  visit contact_path
  fill_in "Name", :with => name
  fill_in "Email", :with => email
  fill_in "Subject", :with => subject
  fill_in "Message", :with => body
  click_button "Submit"
end
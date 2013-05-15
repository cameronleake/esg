# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Esg::Application.initialize!

MAILCHIMP_ESG_BLOG = { :API_key => "46321100908d098dcb744572daac886b-us7", :list_id => "81ad01eabe" }

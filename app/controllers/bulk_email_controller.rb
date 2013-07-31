class BulkEmailController < ApplicationController
                   
  
  def create_campaign
    @gb = Gibbon::API.new(MAILCHIMP_API_KEY) 
    @from_email = "development@engineeringsurvivalguide.com"     
    @from_name = "EngineeringSurvivalGuide"
    @subject = "Test Newsletter"   
    @content = "<html><head></head><body><h1>TEST</h1><p>TEST</p></body></html>"  # render "user_mailer/welcome_message"
    @campaign_id = @gb.campaigns.create({type: "regular", options: {list_id: ESG_MAILING_LIST_ID, subject: @subject, from_email: @from_email, from_name: @from_name, generate_text: true}, content: {html: @content}})
    @gb.campaigns.send({:cid => @campaign_id.id})
  end                                                                                                                                                                                                  
  
  
  # def send_campaign(campaign_id) 
  #   @gb = Gibbon::API.new(MAILCHIMP_API_KEY) 
  #   @gb.campaigns.send( :cid => campaign_id )
  # end    
  
end
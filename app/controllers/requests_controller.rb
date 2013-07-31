class RequestsController < ApplicationController
             
  def index
    @request = Request.new                
    @requests = Request.order("created_at DESC").all              
    @categories = Category.all.collect{ |a| [a.name, a.id]}
  end


  def create           
    @user = current_user                      
    @categories = Category.all.collect{ |a| [a.name, a.id]}   
    @request = Request.create(params[:request])
    @request.user_id = @user_id        
    if @request.save
      redirect_to requests_path, :notice => "Request Submitted"
    else
      render "index"
    end
  end

end

class ReviewsController < ApplicationController
  
  def create
    @user = current_user
    @resource = Resource.find(params[:resource_id])
    @category = Category.find(params[:category_id])
    @review = @resource.reviews.build(params[:review])
    @review.user_id = @user.id
    
    if @user.already_submitted_review(@resource)
      redirect_to category_resource_path(@category, @resource), alert: "You have already submitted a review for this resource!" 
    elsif @review.body? && @review.title? && @review.spam?
      @review.spam = true
      @review.save!
      redirect_to category_resource_path(@category, @resource), alert: "We're sorry, this review has been marked as spam!"
    elsif @review.body? && @review.title?
      @review.save!
      redirect_to category_resource_path(@category, @resource), notice: "Review submitted!"
    else
      redirect_to category_resource_path(@category, @resource), alert: "Review must have a Title and a Review!"
    end
  end
  
end

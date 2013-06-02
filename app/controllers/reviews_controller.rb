class ReviewsController < ApplicationController
  
  def create
    @resource = Resource.find(params[:resource_id])
    @category = Category.find(params[:category_id])
    @review = @resource.reviews.build(params[:review])
    @review.user_id = current_user.id
    
    # If review is not spam and not blank
    if @review.body? && @review.spam?
      @review.spam = true
      @review.save!
      redirect_to category_resource_path(@category, @resource), alert: "We're sorry, this review has been marked as spam!"
    elsif @review.body?
      @review.save!
      redirect_to category_resource_path(@category, @resource), notice: "Review submitted!"
    else
      redirect_to category_resource_path(@category, @resource), alert: "Cannot submit a blank review!"
    end
  end
  
end

class ReviewsController < ApplicationController
  # non-logged-in users cannot be accessed
  before_filter :require_user

  def create
    @review = Review.new(review_params)
    @review.user = current_user
    @review.product_id = params[:product_id]

    if @review.save
      redirect_to product_path(id: params[:product_id]), notice: 'Review created!'
    else
      redirect_to :back
    end
  end

  def destroy
    @review = Review.find params[:id]
    @review.destroy
    redirect_to product_path(id: params[:product_id]), notice: 'Review deleted!'
  end

  def review_params
    params.require(:review).permit(
      :description,
      :rating
    )
  end
end

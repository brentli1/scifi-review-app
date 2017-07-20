class ReviewsController < ApplicationController
  def show
    @review = Review.find(params[:id])
  end

  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id

    if @review.save
      flash[:success] = "Your review has been successfully added."
      redirect_to movie_path(@review.movie)
    else
      flash[:danger] = @review.errors.full_messages.to_sentence
      redirect_to :back
    end
  end

  private
  def review_params
    params.require(:review).permit(:review_body, :movie_id, :rating)
  end
end

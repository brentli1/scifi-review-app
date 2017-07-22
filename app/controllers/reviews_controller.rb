class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :review, :destroy]
  before_action :is_same_user, only: [:edit, :update, :destroy]

  def show
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

  def edit
  end

  def update
    if @review.update(review_params)
      flash[:success] = "Your review was successfully updated."
      redirect_to review_path(@review)
    else
      render 'edit'
    end
  end

  def destroy
    current_movie = @review.movie
    @review.destroy
    flash[:danger] = "Review has been removed."
    redirect_to movie_path(current_movie)
  end

  private
  def review_params
    params.require(:review).permit(:review_body, :movie_id, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Only admins can perform that action!"
      redirect_to root_path
    end
  end

  def is_same_user
    if @review.user.id != current_user.id && !current_user.admin?
      flash[:danger] = "You are not authorized to perform that action."
      redirect_to review_path(@review)
    end
  end
end

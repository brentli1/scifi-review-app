class MoviesController < ApplicationController
  before_action :require_admin, except: [:show]
  before_action :set_movie, only: [:edit, :show, :update, :destroy]

  def show
    @review = Review.new

    unless @movie.reviews.blank?
      @movie_avg = @movie.reviews.average(:rating)
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      flash[:success] = "#{@movie.title} has been added to the movie list!"
      redirect_to movie_path(@movie)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      flash[:success] = "Movie was successfully updated!"
      redirect_to movie_path(@movie)
    else
      render 'edit'
    end
  end

  private
  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :release_date, :synopsis, :image)
  end

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Only admins can perform that action!"
      redirect_to root_path
    end
  end
end

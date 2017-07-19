class MoviesController < ApplicationController
  before_action :require_admin, except: [:show]

  def show
    @movie = Movie.find(params[:id])
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

  private
  def movie_params
    params.require(:movie).permit(:title, :release_date, :synopsis)
  end

  def require_admin
    if !current_user.admin?
      flash[:danger] = "Only admins can perform that action!"
      redirect_to root_path
    end
  end
end

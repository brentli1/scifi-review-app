class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  
  def index
    if current_user
      @latest_movies = Movie.order('created_at DESC').limit(6)
    end
  end
end

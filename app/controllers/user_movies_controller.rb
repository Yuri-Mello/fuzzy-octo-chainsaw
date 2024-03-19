class UserMoviesController < ApplicationController
  before_action :authenticate_user!

  def create
    @movie = Movie.find(params[:user_movie][:movie_id])
    current_user.movies << @movie
    @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end

  def bulk_create
    if File.extname(params[:file]) == ".csv"
      File.open(params[:file]) do |file|
        csv = CSV.parse(file, headers: true)
        csv.each do |score|
          @movie = Movie.find(score['movie_id'])
          current_user.movies << @movie
          @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
          @user_movie.update(score: score['score'])
        end
      end
    end
    redirect_to movies_path
  end

  def update
    @user_movie = current_user.user_movies.find_by(movie_id: params[:user_movie][:movie_id])
    @user_movie.update(score: params[:user_movie][:score])
    redirect_to movies_path
  end
end

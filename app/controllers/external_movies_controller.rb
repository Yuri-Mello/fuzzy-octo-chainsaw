class ExternalMoviesController < ApplicationController
  skip_before_action :verify_authenticity_token
  require 'csv'

  def index
    @movies = Movie.all
    render json: { data: @movies }
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save
  end

  def bulk_create
    if File.extname(params[:file]) == ".csv"
      File.open(params[:file]) do |file|
        BulkCreateMoviesJob.perform_async(CSV.parse(file).to_a)
      end
    end
    redirect_to movies_path, notice: "Movies are being created."
  end

  private

  def movie_params
    params.require(:external_movie).permit(:title, :director)
  end
end

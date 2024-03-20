class MoviesController < ApplicationController
  before_action :authenticate_user!
  require 'csv'

  def index
    @movies = Movie.all
    respond_to do |format|
      format.html
      format.json { render json: @movies.to_json(methods: :average_score) }
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to movies_path, notice: "Movie was successfully created."
    else
      render :new
    end
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
    params.require(:movie).permit(:title, :director)
  end
end

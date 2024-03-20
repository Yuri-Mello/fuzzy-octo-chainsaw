class BulkCreateUserMoviesJob
  include Sidekiq::Job

  def perform(data, user_id)
    data.each do |score|
      @movie = Movie.find(score[0])
      current_user ||= User.find(user_id) if user_id
      current_user.movies << @movie
      @user_movie = current_user.user_movies.find_by(movie_id: @movie.id)
      @user_movie.update(score: score[1])
    end
  end
end

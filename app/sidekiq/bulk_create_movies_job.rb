class BulkCreateMoviesJob
  include Sidekiq::Job

  def perform(data)
    data.each do |movie|
      @movie = Movie.new(title: movie[0], director: movie[1])
      @movie.save
    end
  end
end

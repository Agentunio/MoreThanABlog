class HelloJob
  include Sidekiq::Job

  def perform(*args)
    puts "Hello word"
  end
end
require 'naive_events_repository'
Sequent.configure do |config|
  config.aggregate_repository = NaiveEventsRepository.new
end

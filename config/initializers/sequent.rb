require 'naive_events_repository'
Sequent.configure do |config|
  config.aggregate_repository = NaiveEventsRepository.new
end

Dir[Rails.root.join('app', 'domains', 'workflows') + '*.rb'].each {|file| require file }
Dir[Rails.root.join('app', 'projectors') + '*.rb'].each {|file| require file }


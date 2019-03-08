class NaiveEventsRepository

  EVENTS_KEY = 'Sequent::Core::NaiveEventsRepository::events'.to_sym
  class HasUncommittedEvents < StandardError; end

  def commit(command)
    store_events command, streams_with_events if streams_with_events.any?
    clear
  end

  def clear
    Thread.current[EVENTS_KEY] = []
  end

  def clear!
    clear
  end

  def create_event(event_class, subject, params = {})
    stream = Sequent.configuration.event_store.find_event_stream(subject.aggregate_id) || Sequent::Core::EventStream.new(aggregate_type: subject.class, aggregate_id: subject.aggregate_id, snapshot_threshold: nil)
    sequence_number = Sequent::Core::EventRecord.where(aggregate_id: subject.aggregate_id).count + 1
    event = event_class.new(params.merge({ sequence_number: sequence_number, aggregate_id: subject.aggregate_id }))
    streams_with_events << [stream, [event]]
  end

  def streams_with_events
    Thread.current[EVENTS_KEY] ||= []
  end

  private

  def store_events(command, streams_with_events)
    Sequent.configuration.event_store.commit_events(command, streams_with_events)
  end
end

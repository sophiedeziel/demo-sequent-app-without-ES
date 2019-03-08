class NaiveEventsRepository

  EVENTS_KEY = 'Sequent::Core::NaiveEventsRepository::events'.to_sym
  class HasUncommittedEvents < StandardError; end

  def commit(command)
    streams_with_events = uncommitted_events.map do |aggregate_id, hash|
      stream = Sequent.configuration.event_store.find_event_stream(aggregate_id) || Sequent::Core::EventStream.new(aggregate_type: hash.class, aggregate_id: aggregate_id, snapshot_threshold: nil)
      [stream, hash[:events]]
    end
    store_events command, streams_with_events if streams_with_events.any?
    clear
  end

  def clear
    Thread.current[EVENTS_KEY] = {}
  end

  def clear!
    clear
  end

  def create_event(event_class, subject, params = {})
    uncommitted_events[subject.aggregate_id] ||= { type: subject.class, events: [] }

    sequence_number = Sequent::Core::EventRecord.where(aggregate_id: subject.aggregate_id).count + 1 + uncommitted_events[subject.aggregate_id][:events].count
    event = event_class.new(params.merge({ sequence_number: sequence_number, aggregate_id: subject.aggregate_id }))
    uncommitted_events[subject.aggregate_id][:events] << event
  end

  def uncommitted_events
    Thread.current[EVENTS_KEY] ||= {}
  end

  private

  def store_events(command, streams_with_events)
    Sequent.configuration.event_store.commit_events(command, streams_with_events)
  end
end

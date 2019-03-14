class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def events
    if respond_to? :aggregate_id
      Sequent::Core::EventRecord.where(aggregate_id: aggregate_id)
    end
  end
end

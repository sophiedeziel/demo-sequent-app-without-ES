class Subscription
  class Event < ApplicationRecord
    belongs_to :subscription, primary_key: :aggregate_id
  end
end

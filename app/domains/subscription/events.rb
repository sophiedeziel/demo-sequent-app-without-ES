module SubscriptionDomain
  class SubscriptionCreated < Sequent::Event
    attrs plan_id: Integer, account_aggregate_id: String
  end

  class SubscriptionCancelled < Sequent::Event
  end
end

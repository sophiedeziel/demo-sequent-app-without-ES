module Subscription
  class SubscriptionCreated < Sequent::Event
    attrs plan_id: Integer
  end

  class SubscriptionCancelled < Sequent::Event
  end
end

module Subscription
  class SubscribeToPlan < Sequent::Command
    attrs plan_id: Integer
    validates_presence_of :plan_id
  end

  class CancelSubscription < Sequent::Command
  end
end

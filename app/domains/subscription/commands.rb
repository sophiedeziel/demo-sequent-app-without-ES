module SubscriptionDomain
  class SubscribeToPlan < Sequent::Command
    attrs plan_id: Integer, account_aggregate_id: String
    validates_presence_of :plan_id, :account_aggregate_id

    def initialize(args = {})
      super(args.merge(aggregate_id: Sequent.new_uuid))
    end
  end

  class CancelSubscription < Sequent::Command
  end
end

module Subscription
  class CommandHandlers < ApplicationCommandHandler
    on SubscribeToPlan do |command|
      attributes = { plan_id: command.plan_id, aggregate_id: command.aggregate_id, account_aggregate_id: command.account_aggregate_id }
      subscription = Subscription.create(attributes)
      repository.create_event SubscriptionCreated, subscription, attributes
    end

    on CancelSubscription do |command|
      subscription = Subscription.find_by!(aggregate_id: command.aggregate_id)
      subscription.update plan_id: nil
      repository.create_event SubscriptionCancelled, subscription
    end
  end
end




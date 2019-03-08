module Subscription
  class CommandHandlers < Sequent::CommandHandler
    on SubscribeToPlan do |command|
      user = User.find_by(aggregate_id: command.aggregate_id)
      user = User.update(plan_id: command.plan_id)
      repository.create_event Subscription::SubscriptionCreated, user, command.attributes
    end
  end
end

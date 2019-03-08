module Subscription
  class CommandHandlers < Sequent::CommandHandler
    on SubscribeToPlan do |command|
      attributes = { plan_id: command.plan_id }
      user = User.find_by(aggregate_id: command.aggregate_id)
      user.update attributes
      repository.create_event Subscription::SubscriptionCreated, user, attributes
    end

    on CancelSubscription do |command|
      user = User.find_by(aggregate_id: command.aggregate_id)
      user.update plan_id: nil
      repository.create_event Subscription::SubscriptionCancelled, user
    end
  end

  Sequent.configure do |config|
    config.command_handlers << Subscription::CommandHandlers.new
  end
end

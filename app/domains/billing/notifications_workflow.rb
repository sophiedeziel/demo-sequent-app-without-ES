module Subscription
  class NotificationsWorkflow < Sequent::Workflow
    on Billing::BalanceUpdated do |event|
      user = User.find_by(aggregate_id: event.aggregate_id)
      Notification.create(
        title: 'You have a new balance',
        content: "Check out your new balance on the Subscription page",
        user: user
      )
    end
  end
end

Sequent.configure do |config|
  config.event_handlers << Subscription::NotificationsWorkflow.new
end

module Subscription
  class PaymentWorkflow < Sequent::Workflow
    on SubscriptionCreated do |event|
      amounts = {
        1 => 200,
        2 => 300,
        3 => 500
      }
      execute_commands Billing::Prepay.new(user_id: 'System', aggregate_id: event.aggregate_id, amount: amounts[event.plan_id])
    end

    on SubscriptionCancelled do |event|
      execute_commands Billing::PaybackBalance.new(user_id: 'System', aggregate_id: event.aggregate_id)
    end
  end

  Sequent.configure do |config|
    config.event_handlers << PaymentWorkflow.new
  end
end

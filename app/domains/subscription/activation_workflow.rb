module Subscription
  class ActivationWorkflow < Sequent::Workflow
    on Billing::PaymentCaptured do |event|
      after_commit do
        execute_commands Advertisement::LaunchCampaign.new
      end
    end

    on SubscriptionCancelled do |event|
      after_commit do
        execute_commands Advertisement::CancelCampaign.new
      end
    end
  end

  Sequent.configure do |config|
    config.event_handlers << PaymentWorkflow.new
  end
end

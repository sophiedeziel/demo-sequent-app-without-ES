class ActivationWorkflow < ApplicationWorkflow
  on Billing::PaymentCaptured do |event|
    after_commit do
      #execute_commands Advertisement::LaunchCampaign.new
    end
  end

  on Subscription::SubscriptionCancelled do |event|
    after_commit do
      #execute_commands Advertisement::CancelCampaign.new
    end
  end
end

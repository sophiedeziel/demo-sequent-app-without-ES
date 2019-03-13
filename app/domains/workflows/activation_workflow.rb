class ActivationWorkflow < ApplicationWorkflow
  on BillingDomain::PaymentCaptured do |event|
    after_commit do
      #execute_commands Advertisement::LaunchCampaign.new
    end
  end

  on SubscriptionDomain::SubscriptionCancelled do |event|
    after_commit do
      #execute_commands Advertisement::CancelCampaign.new
    end
  end
end

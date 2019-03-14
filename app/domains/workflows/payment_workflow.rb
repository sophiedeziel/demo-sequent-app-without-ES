class PaymentWorkflow < ApplicationWorkflow
  on Account::UserCreated do |event|
    execute_commands Billing::CreateBillingAccount.new(account_aggregate_id: event.aggregate_id)
  end

  on Subscription::SubscriptionCreated do |event|
    amounts = {
      1 => 200,
      2 => 300,
      3 => 500
    }
    billing_account = Billing::Account.find_by!(account_aggregate_id: event.account_aggregate_id)
    execute_commands Billing::Prepay.new(aggregate_id: billing_account.aggregate_id, amount: amounts[event.plan_id])
  end

  on Subscription::SubscriptionCancelled do |event|
    subscription = Subscription::Subscription.find_by!(aggregate_id: event.aggregate_id)
    billing_account = Billing::Account.find_by!(account_aggregate_id: subscription.account_aggregate_id)
    execute_commands Billing::PaybackBalance.new(aggregate_id: billing_account.aggregate_id)
  end
end

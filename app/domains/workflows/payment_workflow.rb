class PaymentWorkflow < ApplicationWorkflow
  on AccountDomain::UserCreated do |event|
    execute_commands BillingDomain::CreateBillingAccount.new(account_aggregate_id: event.aggregate_id)
  end

  on SubscriptionDomain::SubscriptionCreated do |event|
    amounts = {
      1 => 200,
      2 => 300,
      3 => 500
    }
    billing_account = BillingDomain::Account.find_by!(account_aggregate_id: event.account_aggregate_id)
    execute_commands BillingDomain::Prepay.new(aggregate_id: billing_account.aggregate_id, amount: amounts[event.plan_id])
  end

  on SubscriptionDomain::SubscriptionCancelled do |event|
    billing_account = BillingDomain::Account.find_by!(account_aggregate_id: event.aggregate_id)
    execute_commands BillingDomain::PaybackBalance.new(aggregate_id: billing_account.aggregate_id)
  end
end

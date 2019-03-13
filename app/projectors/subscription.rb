class SubscriptionProjector < ApplicationProjector
  manages_tables Subscription, Subscription::Event

  on SubscriptionDomain::SubscriptionCreated do |event|
    create_record(Subscription, { aggregate_id: event.aggregate_id, user_id: event.account_aggregate_id })
    create_record(Subscription::Event, { subscription_id: event.aggregate_id })
  end

  on BillingDomain::BalanceUpdated do |event|
    update_all_records(
      Subscription,
      { billing_account_aggregate_id: event.aggregate_id }, # the where clause as a hash
      event.attributes.slice(:balance) # the updates as a hash
    )
  end

  on SubscriptionDomain::SubscriptionCancelled do |event|

  end
end

class SubscriptiondomainSubscription < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptiondomain_subscriptions do |t|
      t.string :plan_id
      t.string :aggregate_id
      t.string :account_aggregate_id
      t.datetime :activated_at
      t.string :activated_by
      t.timestamps
    end
  end
end

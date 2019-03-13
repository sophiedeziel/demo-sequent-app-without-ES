class AddAggregateIdToSubscriptions < ActiveRecord::Migration[6.0]
  def change
    add_column :subscriptions, :aggregate_id, :string
    add_column :subscriptions, :billing_account_aggregate_id, :string
  end
end

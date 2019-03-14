class RemoveProjections < ActiveRecord::Migration[6.0]
  def change
    drop_table :subscription_events
    drop_table :subscriptions
  end
end

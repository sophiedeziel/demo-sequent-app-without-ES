class RenameWeirdlyNamedTables < ActiveRecord::Migration[6.0]
  def change
    rename_table :billingdomain_accounts, :billing_accounts
    rename_table :subscriptiondomain_subscriptions, :subscription_subscriptions
    rename_table :users, :account_users
  end
end

module Account
  class User < ApplicationRecord
    has_one :billing_account, primary_key: :aggregate_id, foreign_key: :account_aggregate_id, class_name: 'Billing::Account'
    has_one :subscription, primary_key: :aggregate_id, foreign_key: :account_aggregate_id, class_name: 'Subscription::Subscription'
  end
end

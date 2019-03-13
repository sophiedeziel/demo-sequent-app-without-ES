class CreateBillingAccounts < ActiveRecord::Migration[6.0]
  def change
    create_table :billingdomain_accounts do |t|
      t.string :aggregate_id
      t.string :account_aggregate_id
      t.decimal :balance
      t.timestamps
    end
  end
end

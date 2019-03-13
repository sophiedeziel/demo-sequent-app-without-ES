class CreateReadSubscription < ActiveRecord::Migration[6.0]
  def change
    create_table :subscriptions do |t|
      t.string  :user_id
      t.integer :plan_id
      t.decimal :balance

      t.timestamps
    end

    create_table :subscription_events do |t|
      t.string :subscription_id
      t.string :name

      t.timestamps
    end
  end
end

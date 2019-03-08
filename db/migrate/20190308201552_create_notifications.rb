class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications do |t|
      t.bigint :user_id
      t.string :title
      t.string :content
      t.datetime :read_at

      t.timestamps
    end
  end
end

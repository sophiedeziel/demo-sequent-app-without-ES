class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :aggregate_id
      t.string :email
      t.string :fullname
      t.string :password

      t.timestamps
    end
  end
end

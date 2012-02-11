class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer   :plan_id
      t.string    :email
      t.string    :stripe_customer_token
      t.integer   :user_id
      t.timestamps
    end
    add_index :subscriptions, :plan_id
    add_index :subscriptions, :user_id
    add_index :subscriptions, :stripe_customer_token
    add_index :subscriptions, :user_id, :unique => true
  end
end

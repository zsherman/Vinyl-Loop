class CreateProspects < ActiveRecord::Migration
  def change
    create_table :prospects do |t|
      t.string  :email
      t.timestamps
    end
    add_index :prospects, :email, :unique => true
  end
end

class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.string    :invite_code
      t.integer   :times_used
      t.timestamps
    end
  end
end

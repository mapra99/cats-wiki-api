class CreateUserClicks < ActiveRecord::Migration[5.2]
  def change
    create_table :user_clicks do |t|
      t.string :path_name, null: false
      t.integer :clicks_amount, null: false
      t.timestamps
    end
  end
end

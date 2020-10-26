class CreateBreedSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :breed_searches do |t|
      t.string :query_term, null: false
      t.boolean :succeed, default: false
      t.string :breed_id
      t.timestamps
    end
  end
end

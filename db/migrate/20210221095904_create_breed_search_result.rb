class CreateBreedSearchResult < ActiveRecord::Migration[5.2]
  def change
    create_table :breed_search_results do |t|
      t.references :breed_search, foreign_key: true
      t.string :breed_id
    end
  end
end

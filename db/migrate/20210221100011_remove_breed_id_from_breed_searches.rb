class RemoveBreedIdFromBreedSearches < ActiveRecord::Migration[5.2]
  def change
    remove_column :breed_searches, :breed_id
  end
end

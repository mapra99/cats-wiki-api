class AddSearchByToBreedSearches < ActiveRecord::Migration[5.2]
  def change
    add_column :breed_searches, :search_by, :string
  end
end

class BreedSearchResult < ApplicationRecord
  belongs_to :breed_search
  validates :breed_id, presence: true
end

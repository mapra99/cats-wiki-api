class BreedSearch < ApplicationRecord
  validates :query_term, presence: true

  def self.top_searches
    []
  end
end

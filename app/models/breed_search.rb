class BreedSearch < ApplicationRecord
  validates :query_term, presence: true

  def self.top_searches
    where(succeed: true)
      .group(:breed_id)
      .count
      .sort_by { |_breed, count| -count }
      .map { |entry| { breed_id: entry[0], count: entry[1] } }
  end
end

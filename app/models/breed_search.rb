class BreedSearch < ApplicationRecord
  validates :query_term, presence: true

  def self.top_searches
    Rails.cache.fetch('breeds/top-searches', expires_in: 1.day) do
      where(succeed: true)
        .group(:breed_id)
        .count
        .sort_by { |_breed, count| -count }
        .map { |entry| { breed_id: entry[0], count: entry[1] } }
    end
  end
end

class BreedSearch < ApplicationRecord
  validates :query_term, presence: true

  def self.top_searches
    where(succeed: true)
      .select(:breed_id, 'count(*) AS count')
      .group(:breed_id)
      .order('count DESC')
  end
end

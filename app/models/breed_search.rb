class BreedSearch < ApplicationRecord
  validates :query_term, presence: true
  validates :search_by, inclusion: { in: BreedServices::SearchService::SEARCH_BY_OPTIONS.map(&:to_s) }, allow_blank: true

  has_many :results, class_name: 'BreedSearchResult', foreign_key: 'breed_search_id'

  def self.top_searches
    where(succeed: true)
      .joins(:results)
      .select(:breed_id, 'count(*) AS count')
      .group(:breed_id)
      .order('count DESC')
  end
end

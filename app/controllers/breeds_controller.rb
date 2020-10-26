class BreedsController < ApplicationController
  def search
    query_term = params[:term]
    render status: :bad_request and return unless query_term.present?

    search = BreedServices::SearchService.new(query_term: query_term)
    search.perform
    search.save_search
    render json: search.results
  end

  def top_searches
    limit = params[:limit] || 10
    top_breeds = BreedServices::TopSearchesService.new.perform(limit: limit)

    render json: top_breeds
  end
end

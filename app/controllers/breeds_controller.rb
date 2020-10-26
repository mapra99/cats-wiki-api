class BreedsController < ApplicationController
  def search
    query_term = params[:term]
    render status: :bad_request and return unless query_term.present?

    search = BreedSearchService.new(query_term: query_term)
    search.perform
    search.save
    render json: search.results
  end
end

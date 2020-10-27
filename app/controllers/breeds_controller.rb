class BreedsController < ApplicationController
  def search
    query_term = params[:term]
    render status: :bad_request and return unless query_term.present?

    images_limit = params[:include_images]&.to_i || 1
    search = BreedServices::SearchService.new(query_term: query_term, include_images: images_limit)
    search.perform
    search.save_search
    render json: search.results
  end

  def top_searches
    limit = params[:limit]&.to_i || 10
    top_breeds = BreedServices::TopSearchesService.new(limit: limit).perform

    render json: top_breeds
  end
end

class BreedsController < ApplicationController
  before_action :set_cache_policy, only: %i[search top_searches]

  def search
    query_term = search_params[:term]
    render status: :bad_request and return unless query_term.present?

    images_limit = search_params[:include_images]&.to_i || 1
    search_by = search_params[:by]&.to_sym || :breed_name

    search = BreedServices::SearchService.new(query_term: query_term, include_images: images_limit, search_by: search_by)
    search.perform
    search.save_search
    render json: search.results
  end

  def top_searches
    limit = params[:limit]&.to_i || 10
    top_breeds = BreedServices::TopSearchesService.new(limit: limit).perform

    render json: top_breeds
  end

  def images
    breed_id = params[:breed_id]
    render status: :bad_request and return unless breed_id.present?

    images_limit = params[:images_limit].to_i || 10
    images_search = BreedServices::ImageSearchService.new(breed_id: breed_id, limit: images_limit)
    images_search.perform
    render json: images_search.results
  end

  private

  def search_params
    params.permit(:term, :include_images, :by).allow(by: BreedServices::SearchService::SEARCH_BY_OPTIONS.map(&:to_s))
  end
end

class BreedsController < ApplicationController
  before_action :set_cache_policy, only: %i[search top_searches]

  before_action :query_term, only: :search
  before_action :images_limit, only: %i[search images]
  before_action :search_by, only: :search
  before_action :limit, only: :top_searches
  before_action :breed_id, only: :images

  def search
    render status: :bad_request and return if @query_term.blank?

    search = BreedServices::SearchService.new(
      query_term: @query_term,
      images_limit: @images_limit || 1,
      search_by: @search_by || :breed_name
    )
    search.perform
    search.save_search

    render json: search.results
  end

  def top_searches
    top_breeds = BreedServices::TopSearchesService.new(
      limit: @limit || 10
    )
    top_breeds.perform

    render json: top_breeds.result
  end

  def images
    render status: :bad_request and return if @breed_id.blank?

    images_search = BreedServices::ImageSearchService.new(
      breed_id: @breed_id,
      limit: @images_limit || 10
    )
    images_search.perform

    render json: images_search.results
  end

  private

  def search_params
    params.permit(:term, :limit, :include_images, :images_limit, :breed_id, :by).allow(by: BreedServices::SearchService::SEARCH_BY_OPTIONS.map(&:to_s))
  end

  def query_term
    @query_term ||= search_params[:term]
  end

  def images_limit
    @images_limit ||= search_params[:images_limit]&.to_i
  end

  def search_by
    @search_by ||= search_params[:by]&.to_sym
  end

  def limit
    @limit ||= search_params[:limit]&.to_i
  end

  def breed_id
    @breed_id ||= search_params[:breed_id]
  end
end

class ApplicationController < ActionController::API
  private

  def set_cache_policy
    return if Rails.env.development?

    expires_in 1.hour, public: true
  end
end

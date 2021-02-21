class ApplicationController < ActionController::API
  private

  def set_cache_policy
    expires_in 1.hour, public: true
  end
end

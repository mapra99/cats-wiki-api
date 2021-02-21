class CatsAPIAdapter
  attr_reader :request_headers, :payload

  def initialize
    @request_headers = set_default_headers
    @base_url = base_url
  end

  def get(path: '', params: {}, headers: {}, cache_payload: false)
    url = @base_url + path
    @request_headers = headers.merge(@request_headers)
    request = @request_headers.merge({params: params})

    if cache_payload
      cache_key = url + params.to_s + headers.to_s
      @payload = Rails.cache.fetch(cache_key, expires_in: 1.week) do
        response = RestClient.get(url, request)
        JSON.parse(response.body)
      end
    else
      response = RestClient.get(url, request)
      @payload = JSON.parse(response.body)
    end
  end

  private

  def set_default_headers
    {
      'x-api-key' => api_key
    }
  end

  def base_url
    ENV['CATS_API_BASE_URL']
  end

  def api_key
    ENV['CATS_API_KEY']
  end
end

class CatsAPIAdapter
  attr_reader :request_headers, :response, :payload

  def initialize
    @request_headers = set_default_headers
    @base_url = base_url
  end

  def get(path: '', params: {}, headers: {})
    url = @base_url + path
    @request_headers = headers.merge(@request_headers)
    request = @request_headers.merge({params: params})

    @response = RestClient.get(url, request)
    @payload = JSON.parse(@response.body)
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

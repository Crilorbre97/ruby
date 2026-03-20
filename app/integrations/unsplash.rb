require "rest-client"

class Unsplash
  def initialize; end

  def random_photo
    response = RestClient::Request.execute(method: :get, url: url, headers: headers)
    json_response = JSON.parse(response.body)
    json_response["urls"]["raw"]
  rescue
    ""
  end

  private

  def headers
    {
      authorization: "Client-ID #{access_key}"
    }
  end

  def access_key
    ENV["UNSPLASH_ACCESS_KEY"]
  end

  def root_url
    ENV["UNSPLASH_URL"]
  end

  def url
    "#{root_url}/photos/random"
  end
end

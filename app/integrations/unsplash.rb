require "net/http"

class Unsplash
  def initialize; end

  def random_phono
    uri = URI("#{url}/photos/random")
    request = Net::HTTP::Get.new(uri)
    request["Authorization"] = "Client-ID #{ENV["UNSPLASH_ACCESS_KEY"]}"
    response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
    json_response = JSON.parse(response.body)
    json_response["urls"]["raw"]
  rescue
    ""
  end

  private

  def url
    ENV["UNSPLASH_URL"]
  end

  def headers
    {
      "Authorization" => "Client-ID #{ENV["UNSPLASH_ACCESS_KEY"]}"
    }
  end
end

module ScraperJsonHelper
  require "net/http"

  def self.get_source_from_uri(url)
    retry_attempts = 3
    begin
        uri = URI(url)
        response = Net::HTTP.get(uri)
        JSON.parse(response)
    rescue StandardError => error
      if retry_attempts > 0
        retry_attempts -= 1
        sleep 5
        retry
      end
      raise error
    end
  end
end
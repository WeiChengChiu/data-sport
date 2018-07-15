module ScraperHelper
  require "open-uri"
  require "net/http"
  require 'nokogiri'

  def self.get_source_from_uri(uri, strict_xml_flag = false)
    result = ""
    retry_attempts = 3
    begin
        if strict_xml_flag
          response = HTTParty.get(URI.encode(uri))
          document = response.body
          result = Nokogiri::XML(document) do |config|
            config.options = Nokogiri::XML::ParseOptions::STRICT | Nokogiri::XML::ParseOptions::NONET
          end
          result.remove_namespaces!
        else
          result = Nokogiri::HTML(open(URI.encode(uri)))
        end
        return result
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
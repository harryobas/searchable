require 'readability'
require 'open-uri'

class PageTextExtractor

  def self.extract_page_text(page_url)
    document = Readability::Document.new(open(page_url))
    text = Nokogiri::HTML(document.content).text.strip.gsub(/\s+/, " ")
    text
  end

end

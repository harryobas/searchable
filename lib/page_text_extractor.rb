require 'readability'
require 'open-uri'

class PageTextExtractor

  def self.extract_page_text(page_url)
    document = Readability::Document.new(open(page_url).read)
    doc_title = document.title
    doc_content = Nokogiri::HTML(document.content).text.strip.gsub(/\s+/, " ")

    [doc_content, doc_title]
  end

end

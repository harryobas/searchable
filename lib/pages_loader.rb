require 'open-uri'
require 'nokogiri'

class PagesLoader

  BASE_URL = "https://en.wikipedia.org"
  URL_PATH = "/wiki/List_of_countries_and_dependencies_by_population"

  def self.call
    source_doc = get_pages_source("#{BASE_URL}#{URL_PATH}")
    pages_text = extract_text_from_pages(source_doc)
    persist_pages(pages_text, source_doc)
  end

  private

  def self.get_pages_source(source_url)
    doc = Nokogiri::HTML(open(source_url))
    countries_table = doc.css('table.wikitable')
    countries = countries_table.first.css('a')

    countries = countries.select{|c| c.attributes['href'].value.start_with?('/wiki')}
  end

  def self.extract_text_from_pages(pages)
     Parallel.map(pages, in_processes: 4) do |p|
      url_path = p.attributes['href'].value
      PageTextExtractor.extract_page_text("#{BASE_URL}#{url_path}")
    end
  end

  def self.persist_pages(texts, docs)
    texts.each do |txt, title_txt|
      docs.each do |doc|
        page_url = doc.attributes['href'].value
        Page.new({url: page_url, title: title_txt, content: txt}).save
      end
    end
  end

end

require 'open-uri'
require 'nokogiri'

class PagesLoader

  BASE_URL = "en.wikipedia.org"
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

    countries = countries.select{|c| c.attributes['href'].value.start_with?('/wiki')
  end

  def extract_text_from_pages(pages)
    pages = pages.map do |p|
      url_path = p.attributes['href'].value
      PageTextExtractor.extract_page_text("#{BASE_URL}#{url_path}")
    end
  end

  def persist_pages(texts, docs)
    texts.each do |txt|
      docs.each do |doc|
        page_url = doc.attributes['name'].value
        Page.new({url: page_url, content: txt}).save
      end
    end
  end


end

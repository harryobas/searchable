class Page
  include Mongoid::Document

  field :url, type: String
  field :title, type: String
  field :content, type: String
end

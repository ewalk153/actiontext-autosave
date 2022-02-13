class Article < ApplicationRecord
  has_rich_text :content
  has_many :draft_articles
end

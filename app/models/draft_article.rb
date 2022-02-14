class DraftArticle < ApplicationRecord
  belongs_to :article

  has_rich_text :content

  SAVE_INTERVAL = 0.5 * 60 * 1000 # 30 sec
end

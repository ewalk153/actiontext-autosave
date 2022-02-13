class Article < ApplicationRecord
  has_rich_text :content
  has_many :draft_articles

  attr_reader :active_draft
  attr_reader :draft_loaded

  def load_draft(draft_id = nil)
    @active_draft = find_draft(draft_id)
    return if active_draft.nil?
    draft_html = active_draft.content.to_s
    current_html = content.to_s
    if draft_html != current_html
      self.content = active_draft.content
      @draft_loaded = true
    else
      @draft_loaded = false
    end
  end

  private
  def find_draft(draft_id)
    draft_id.nil? ? draft_articles.last : draft_articles.find(draft_id)
  end
end

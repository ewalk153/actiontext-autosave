json.extract! draft_article, :id, :content, :article_id, :created_at, :updated_at
json.url draft_article_url(draft_article, format: :json)

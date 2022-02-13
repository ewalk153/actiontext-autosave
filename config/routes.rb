Rails.application.routes.draw do
  resources :articles do
    resources :draft_articles
  end
end

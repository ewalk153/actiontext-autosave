Rails.application.routes.draw do
  resources :articles do
    resources :draft_articles, only: %i[ index create show ]
  end
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root to: 'page#load_pages'
      get 'pages/search' => 'page#search'

      resources :pages, only: [:index]
    end
  end
end

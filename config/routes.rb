Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      root to: 'pages#load_pages'
      get 'pages/search' => 'pages#search'
    end
  end 
end

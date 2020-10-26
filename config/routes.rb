Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/breeds/search', to: 'breeds#search', as: :breed_search
  get '/breeds/top-searches', to: 'breeds#top_searches', as: :breed_top_searches
end

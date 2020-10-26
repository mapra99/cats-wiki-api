Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/search-breed', to: 'breeds#search', as: :search_breed
end

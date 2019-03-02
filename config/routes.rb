Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/feedings', to: 'feedings#index'
  get '/feedings/side/:side', to: 'feedings#index_by_side'
  get '/feedings/last_hours/:n', to: 'feedings#index_of_last_n_hours'
  get '/feedings/:start/:finish', to: 'feedings#index_between_times'
  get '/feedings/:id', to: 'feedings#show'
  post '/feedings', to: 'feedings#create'
  delete '/feedings/:id', to: 'feedings#delete'
  put '/feedings/:id', to: 'feedings#update'
end

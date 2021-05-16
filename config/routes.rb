Rails.application.routes.draw do
  namespace :api do
    resources :users
    get '/api/typeahead/:search', to: 'users#typehead'
  end
end

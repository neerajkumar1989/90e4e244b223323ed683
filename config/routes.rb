Rails.application.routes.draw do
  namespace :api do
    resources :users
    get 'typehead/:search', to: 'users#typehead'
  end
end

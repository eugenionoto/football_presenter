Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :football_players, only: [:index]
  
  root :to => redirect('football_players')
end

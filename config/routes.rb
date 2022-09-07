Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root to: "pages#landing"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "albums", to: "albums#index"
  #get 'albums/cards'
  #get 'albums/quizzes'
end

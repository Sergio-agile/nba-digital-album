Rails.application.routes.draw do
  get 'albums/cards'
  get 'albums/quizzes'
  devise_for :users
  #root to: "pages#home"
  root to: "pages#landing"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

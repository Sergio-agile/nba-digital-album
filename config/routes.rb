Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root to: "pages#landing"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "albums", to: "albums#index"

  #get 'albums/cards'
  #get 'albums/quizzes'
  resources :quizzes, only: [:show]

  resources :albums, only: [:show] do
    resources :packs, only: [:show]
  end

  get "contact_us", to: "pages#contact_us"
  get "about_us", to: "pages#about_us"
end

# NEED TO SORT OUT ROOTS FROM QUIZ TO PACKS - SO OPENS RIGHT PACK FOR THE ALBUM IT CAME FROM

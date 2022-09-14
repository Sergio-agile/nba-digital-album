Rails.application.routes.draw do
  devise_for :users
  # Defines the root path route ("/")
  root to: "pages#landing"


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get "albums", to: "albums#index"

  #get 'albums/cards'
  #get 'albums/quizzes'



  # get "viewing-album", to: "pages#viewing_album"
  # get "pack", to: "pages#pack"
  resources :albums, only: [:index, :show] do
    resources :quizzes, only: [:show]
    resources :packs, only: [:show]
  end

  get "contact_us", to: "pages#contact_us"
  get "about_us", to: "pages#about_us"
end

# NEED TO SORT OUT ROOTS FROM QUIZ TO PACKS - SO OPENS RIGHT PACK FOR THE ALBUM IT CAME FROM

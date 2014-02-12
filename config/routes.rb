Polymorf::Application.routes.draw do
  get "videos/index"
  get "videos/show"
  get "/", to: "books#index"
  resources :books, :photos do
    resources :comments
  end
end

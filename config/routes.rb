Polymorf::Application.routes.draw do
  get "/", to: "books#index"
  resources :books do
    resources :comments
  end
end

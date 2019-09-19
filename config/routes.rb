Rails.application.routes.draw do
  root 'static_pages#home'

  #sign up
  get '/signup', to: 'authors#new'
  post '/signup', to: 'authors#create'

  #log in
  get '/login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # route for like/dislike course
  post 'books/:id/likebook', to: 'likebooks#new', as: 'likebook'
  post 'books/:id/dislikebook', to: 'dislikebooks#new', as: 'dislikebook'
  delete 'books/:id/rating', to: 'books#reset', as: 'reset'

  # Handle error and redirect to proper error page
  get '/404', to: 'errors#index', :via => :all, as: :error404
  get '/422', to: 'errors#unprocessable', :via => :all, as: :error422
  get '/500', to: 'errors#internal_server_error', :via => :all, as: :error500

  resources :authors
  resources :books
  resources :categories
  resources :distributors

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      resources :books, param: :name, except: [:new, :create, :edit, :destroy]
    end
  end
end

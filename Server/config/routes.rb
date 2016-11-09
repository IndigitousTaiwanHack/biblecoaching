Rails.application.routes.draw do
  root  to:'home#index'

  get 'signup', to: "users#new", as: "signup"
  post 'register', to: "users#create", as: "register"
  post "users/like",to: "users#like", as: "user_like"
  get 'users/post_list', to: "users#post_list", as: "user_post_list"
  get 'users/:id', to: "users#show", as: "user"

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'logout', to: 'sessions#destroy', as: 'logout'

  get 'bible/download', to: "bible#download", as: "download"
  get 'bible/prepare', to: "bible#prepare"
  get "bible/:id/bid", to:"bible#bid", as:"get_bid"
  get "bible/:bid/content", to:"bible#get_content", as:"get_content"

  resources :bible, only:[:index,:create]

  get "posts/new/:bid", to: "posts#new", as:"new_post"
  get "posts/:id", to: "posts#show", as:"post"
  get "posts", to: "posts#index", as:"post_index"
  post "posts", to: "posts#create", as:"create_post"

  post "responses", to: "responses#create", as:"create_response"

  namespace :api, defaults: {format: 'json'} do
    get "user/:uid/profile", to: "users#show"
    get "user/:uid/post_list", to: "users#post_list"
    post 'user/login', to: "users#login"
    post 'user/register', to: "users#register"
    post 'user/like', to: "users#like"
    post 'user/unlike', to: "users#unlike"

    get "bible/popular", to: "bible#popular"
    get "bible/emotion", to: "bible#emotion"
    get "bible/:bid", to: "bible#show"
    get "bibles", to: "bible#index"
    get "book_list", to: "bible#book_list"
    get "bible_list", to: "bible#bible_list"

    get "posts/popular", to: "posts#popular"
    get "posts/:id/show", to: "posts#show"
    get "posts/recommend_list", to: "posts#recommend_list"
    get "posts/latest_list", to: "posts#latest_list"
    post "posts/create", to: "posts#create"

    get "responses", to: "responses#index"
    post "responses/create", to: "responses#create"

    post "ranks/create", to: "ranks#create"
  end
end

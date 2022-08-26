Rails.application.routes.draw do
  get "movies/filter/:filter" => "movies#index", as: :filtered_movies

  def index
    case params[:filter]
    when "upcoming"
      @movies = Movie.upcoming
    when "recent"
      @movies = Movie.recent
    else
      @movies = Movie.released
    end
  end

  resources :genres
  resources :users
  get "signup" => "users#new"
  root "movies#index"

  resources :movies do
    resources :reviews
    resources :favorites, only: [:create, :destroy]
  end

  resource :session, only: [:new, :create, :destroy]
  get "signin" => "sessions#new"
end

Rails.application.routes.draw do
  
  get 'likes/create'
  get 'likes/destroy'
  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :ideas do
  # Routes written inside of a block passed
  # to a 'resources' method will be pre-fixed
  # by a path corresponding to the passed in symbol.
  # In this case all nested routes will be
  # prefixed with '/questions/:question_id/'
  resources :reviews, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
end
  get('/', { to: 'ideas#index', as: 'root' })

end

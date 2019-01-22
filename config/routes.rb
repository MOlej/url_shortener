Rails.application.routes.draw do
  root to: 'urls#new'

  resources :urls, only: %i[new create]

  get '/show/:shortened_url', to: 'urls#show', as: :show_url
  get '/:shortened_url', to: 'urls#redirect_to_original_url', as: :redirect_to_original_url
end

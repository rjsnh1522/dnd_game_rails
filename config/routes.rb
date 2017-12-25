Rails.application.routes.draw do
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations',

    
  # }

  devise_for :users, skip: [:sessions,:registrations]
  as :user do
    post '/users', to: 'users/registrations#create'
    post '/users/sign_in', to: 'users/sessions#create', as: :user_session
    get '/users/current_logged_in_user', to: 'users/sessions#current_logged_in_user', as: :current_logged_in_user
  end
  
end

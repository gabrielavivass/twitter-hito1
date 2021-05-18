Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
    resources :tweets do 
      post :follower
      resources :likes
       member do
        post 'retweet'
    end
  end

  devise_scope :user do
    post 'follow/:id', to: 'friends#follow', as: 'follow_user'
    delete 'follow/:id', to: 'friends#unfollow', as: 'unfollow_user'
  end


  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
    } 
    
  root "tweets#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do

  get 'groups' => 'groups#index'
  post 'groups' => 'groups#create'
  get 'groups/:id' => 'groups#show'
  get 'users' => 'users#index'
  post 'users' => 'users#create'
  post 'users/login' => 'users#login'
  post 'sessions' => 'sessions#create'
  post 'sessions/logout' => 'sessions#destroy'
  get 'JoinGroup/:id' => 'groups#join'
  get 'LeaveGroup/:id' => 'groups#leave'
  get 'delete/:id' => 'groups#delete_group'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

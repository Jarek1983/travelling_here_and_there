Rails.application.routes.draw do

  get 'about/index'
  devise_for :users
  root 'welcome#index'
  get 'welcome/index'
  resources :messages

  resources :articles do
    get 'toggle_visibility', on: :member
    resources :comments do
      resources :grades
      end
    resources :likes, only: [:create, :destroy]
  end

  
    
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}
  devise_scope :user do
    get '/sign_in', to: 'public/sessions#new'
  end

  devise_for :admins, skip: [:registrations, :passwords] ,controllers: {
  sessions: "admin/sessions"
}
  
  root to: 'homes#top'

  get '/' => 'homes#top'
  get '/about' => 'homes#about'
    
  resources :users,  only: [:show, :edit, :update] do
    get '/unsubscribe' => 'users#unsubscribe'
    patch '/withdrawal' => 'users#withdrawa'
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
 end
 
  resources :posts, only: [:index,:show,:edit,:create,:destroy,:update] do
    resource :comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
    
    get 'searches/search' => "searches#search", as: 'search'
  
  namespace :admin do
    resource :owners,  only: [:show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
  end
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

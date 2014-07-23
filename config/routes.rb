DeliveryUncle::Engine.routes.draw do
  resources :email_requests, only: [:index, :show] do
    get :pause_all, on: :member
    get :pause, on: :member
    get :retry_all, on: :member
    get :retry, on: :member
    get :configure, on: :collection
    post :block, on: :collection
    post :unblock, on: :collection
  end
  
  root to: 'email_requests#index'
end

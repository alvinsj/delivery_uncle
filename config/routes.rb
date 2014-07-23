DeliveryUncle::Engine.routes.draw do
  resources :email_requests do
    get :pause_all, on: :member
    get :pause, on: :member
    get :retry_all, on: :member
    get :retry, on: :member
  end
  
  root to: 'email_requests#index'
end

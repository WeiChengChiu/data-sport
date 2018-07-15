Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :games, only: [:index] do
    collection do
      get :destroy_all
      get :update_all
    end
  end

  resources :teams, only: [:index] do
    collection do
      get :destroy_all
      get :update_all
    end
  end

  scope :path => '/api/v1/', :module => "api_v1", :as => 'v1', :defaults => { :format => :json } do
    resources :games, only: [:index]
    resources :teams, only: [:index]
  end
end

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
end

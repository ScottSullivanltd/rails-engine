Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/merchants/find", to: "search#show"
      get "/items/find_all", to: "search#find_all_items"
      resources :merchants, only: [:index, :show] do
        resources :items, controller: "merchant_items", action: :index
      end
      resources :items do
        resources :merchant, controller: "merchant_items", action: :show
      end
    end
  end
end

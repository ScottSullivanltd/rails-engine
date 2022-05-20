Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get "/items/find_all", to: "item_search#index"
      get "/merchants/find", to: "merchant_search#index"
      resources :merchants, only: [:index, :show] do
        resources :items, controller: "merchant_items", action: :index
      end

      resources :items do
        resources :merchant, controller: "merchant_items", action: :show
      end
    end
  end
end

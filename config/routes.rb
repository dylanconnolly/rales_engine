Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resources :most_revenue, only: :index
        resources :find, only: :index
        resources :find_all, only: :index
        resources :random, only: :index
        resources :revenue, only: :index
      end

      resources :merchants, only: [:index, :show] do
        scope module: 'merchants' do
          resources :items, only: :index
          resources :invoices, only: :index
          resources :favorite_customer, only: :index
        end
      end

      namespace :items do
        resources :find, only: :index
        resources :find_all, only: :index
        resources :random, only: :index, :controller => "random_item"
      end

      resources :items, only: [:index, :show] do
        scope module: 'items' do
          resources :invoice_items, only: :index
          resources :merchant, only: :index
        end
      end
    end
  end
end

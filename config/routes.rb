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
        resources :most_revenue, only: :index
      end

      resources :items, only: [:index, :show] do
        scope module: 'items' do
          resources :invoice_items, only: :index
          resources :merchant, only: :index
          resources :best_day, only: :index
        end
      end

      namespace :invoices do
        resources :find, only: :index
        resources :find_all, only: :index
      end

      resources :invoices, only: [:index, :show]

      namespace :invoice_items do
        resources :find, only: :index
        resources :find_all, only: :index
        resources :random, only: :index, :controller => "random_invoice_item"
      end

      resources :invoice_items, only: [:index, :show] do
        scope module: 'invoice_items' do
          resources :invoice, only: :index
          resources :item , only: :index
        end
      end

      namespace :transactions do
        resources :find, only: :index
        resources :find_all, only: :index
      end
      resources :transactions, only: [:index, :show]

      namespace :customers do
        resources :find, only: :index
        resources :find_all, only: :index
        resources :random, only: :index, :controller => "random_customer"
      end

      resources :customers, only: [:index, :show] do
        scope module: 'customers' do
          resources :invoices, only: :index
          resources :transactions, only: :index
        end
      end
    end
  end
end

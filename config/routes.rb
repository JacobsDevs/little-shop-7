Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

	resources :merchants, controller: 'merchant' do
		resources :items, only: [:create, :new, :index, :show, :edit, :update], controller: 'merchant/item' do
      collection do
        get :change_status
      end
    end
		resources :invoices, only: [:index, :show], controller: 'merchant/invoice'
		member do
			get :dashboard, action: 'dashboard'
		end
	end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

	resources :merchants, controller: 'merchant' do
		resources :items, :invoices, only: :index
		member do
			get :dashboard, action: 'dashboard'
		end
	end
end

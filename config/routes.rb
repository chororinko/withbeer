Rails.application.routes.draw do
  namespace :public do
    get 'recommendations/index'
    get 'recommendations/show'
  end
  namespace :admin do
    get 'recipes/index'
    get 'recipes/show'
  end
  namespace :admin do
    get 'customers/index'
    get 'customers/show'
  end
  namespace :admin do
    get 'recommendations/index'
    get 'recommendations/new'
    get 'recommendations/show'
  end
  namespace :admin do
    get 'homes/top'
  end
  namespace :public do
    get 'tags/index'
    get 'tags/new'
  end
  namespace :public do
    get 'favorites/index'
  end
  namespace :public do
    get 'recipes/new'
    get 'recipes/show'
  end
  namespace :public do
    get 'snacks/index'
    get 'snacks/show'
    get 'snacks/new'
  end
  namespace :public do
    get 'customers/show'
  end
  namespace :public do
    get 'sakes/index'
    get 'sakes/show'
  end
  namespace :public do
    get 'homes/top'
  end
  devise_for :admins
  devise_for :customers
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

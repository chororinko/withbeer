Rails.application.routes.draw do
  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations], controllers: {
  sessions: "admin/sessions"
  }

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, controllers: {
  registrations: "public/registrations",
  sessions: 'public/sessions'
}

  namespace :admin do
    root to: 'homes#top'
    resources :recommendations, only: [:new, :create, :index, :show, :edit, :update, :destroy]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :recipes, only: [:index, :show, :edit, :destroy] do
      resources :recipe_comments, only: [:destroy]
    end
  end

  scope module: :public do
    root to: 'homes#top'
    resources :sakes, only: [:index, :show]
    get 'customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:show, :edit, :update]
  end

  namespace :public do
    get 'recommendations/index'
    get 'recommendations/show'
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
  # namespace :public do
  #   get 'sakes/index'
  #   get 'sakes/show'
  # end
  # namespace :public do
  #   get 'homes/top'
  # end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

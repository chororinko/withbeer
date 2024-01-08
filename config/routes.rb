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
    get 'customers/mypage' => 'customers#show', as: 'mypage'
    resources :sakes, only: [:index, :show]

    get 'customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:show, :edit, :update]

    resources :snacks do
      resources :tags, only: [:index, :create, :new, :destroy], controller: 'snack_tags'
    end

    resources :recipes, only: [:new, :create, :show, :edit, :update, :destroy] do
      resources :recipe_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :favorites, only: [:index]

    resources :recommendations, only: [:index, :show]
  end

  get '/search' => 'searches#search'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

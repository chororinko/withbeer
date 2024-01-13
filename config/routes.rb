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

  get "search_tag" => "snacks#search_tag"
  get '/search' => 'searches#search'

  namespace :admin do
    root to: 'homes#top'
    get 'customers/:customer_id/snacks' => 'snacks#index', as: 'customer_snacks'
    resources :recommendations
    resources :customers, only: [:index, :show, :edit, :update]
    resources :sakes, only: [:index, :edit, :create, :update, :destroy]

    resources :snacks, only: [:index, :show, :edit, :destroy] do
      resources :snack_comments, only: [:destroy]
    end
  end

  scope module: :public do
    root to: 'homes#top'
    resources :sakes, only: [:index, :show] do
      resources :snacks, only: [:index, :show]
    end

    get 'customers/confirm_withdraw' => 'customers#confirm_withdraw'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:show, :edit, :update] do
      member do
      get :favorites
      end
    end

    resources :tags, only: [:index, :create, :new, :destroy] do
      resources :snacks, only: [:index]
    end

    resources :snacks, only: [:new, :edit, :show, :create, :update, :destroy] do
      resources :snack_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
    # resources :favorites, only: [:index]
    resources :recommendations, only: [:index, :show]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

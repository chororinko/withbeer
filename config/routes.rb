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

  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  get '/search' => 'searches#search'
  get "customers" => redirect("/customers/sign_up")   # 新規会員登録に失敗してリロードした場合のリダイレクト処理

  namespace :admin do
    root to: 'recommendation_snacks#index'
    get 'customers/:customer_id/snacks' => 'snacks#index', as: 'customer_snacks'

    resources :customers, only: [:index, :show, :edit, :update]
    resources :sakes, only: [:index, :edit, :create, :update, :destroy]

    resources :snacks do
      resources :snack_comments, only: [:destroy]
    end
    resources :recommendation_snacks
  end

  scope module: :public do
    root to: 'homes#top'
    resources :recommendations, only: [:index, :show]

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

    get "search_tag" => "snacks#search_tag"
    resources :tags, only: [:index, :create, :new, :destroy]

    get "snacks" => redirect("/snacks/new")  # 投稿に失敗してリロードした場合のリダイレクト処理

    resources :snacks, only: [:new, :edit, :show, :create, :update, :destroy] do
      resources :snack_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

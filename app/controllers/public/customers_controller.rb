class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:show]
  before_action :is_matching_login_customer, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  before_action :set_customer, only: [:show, :edit, :update]

  def show
    @snacks = @customer.snacks.order(created_at: :desc).page(params[:page]).per(10)
  end

  def favorites
    @customer = current_customer
    @favorites = @customer.favorites.includes(:snack).order(created_at: :desc).page(params[:page]).per(10)    #ログインしているユーザーがいいねした投稿の情報を取得
    @snacks = @favorites.map(&:snack)    # いいねした投稿に関連付けられたおつまみの情報を@snacksに格納
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = 'プロフィールの編集に成功しました。'
      redirect_to customer_path(@customer)
    else
      render :edit
    end
  end

  def confirm_withdraw
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = '退会しました。'
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:user_name, :introduction, :profile_image)
  end

  def is_matching_login_customer
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to customer_path(current_customer)
    end
  end

  def ensure_guest_user
    @customer = Customer.find(params[:id])
    if @customer.guest_user?
      redirect_to customer_path(current_customer) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

end

class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, except: [:show]
  before_action :is_matching_login_customer, only: [:edit, :update, :withdraw]
  before_action :ensure_guest_user, only: [:edit]

  def show
    # @customer = current_customer
    @customer = Customer.find(params[:id])
    @snacks = @customer.snacks.all
  end

  def favorites
    @customer = current_customer
    @favorites = @customer.favorites.includes(:snack)    #ログインしているユーザーがいいねした投稿の情報を取得
    @snacks = @favorites.map(&:snack)    # いいねした投稿に関連付けられたおつまみの情報を@snacksに格納
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = 'プロフィールの編集に成功しました。'
      redirect_to customer_path(@customer)
    else
      flash[:notice] = 'プロフィールの編集に失敗しました。'
      render :edit
    end
  end

  def confirm_withdraw
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:user_name, :introduction, :profile_image)
  end

  def is_matching_login_customer
    customer = current_customer
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

end

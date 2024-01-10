class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_matching_login_customer, only: [:edit, :update]

  def show
    @customer = current_customer
    @snacks = @customer.snacks.all
    # @favorite = snack.favorite.count
    # @recipe_comment = snack.recipe_comment.count
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = 'プロフィールの編集に成功しました。'
      redirect_to mypage_path
    else
      flash[:notice] = 'プロフィールの編集に失敗しました。'
      render :edit
    end
  end

  def confirm_withdraw
  end

  def withdraw
    @customer.update(is_active: false)
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:user_name, :introduction, :profile_image)
  end

  def is_matching_login_customer
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to maypage(current_customer)
    end
  end

end

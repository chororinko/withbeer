class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!, exept: [:show]
  before_action :is_matching_login_customer, only: [:edit, :update, :withdraw]

  def show
    # @customer = current_customer
    @customer = Customer.find(params[:id])
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
      redirect_to customer_path(@customer)
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
      redirect_to customer_path(current_customer)
    end
  end

end

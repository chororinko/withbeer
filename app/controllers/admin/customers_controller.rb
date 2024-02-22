class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.page(params[:page]).order(created_at: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:alert] = '会員ステータスの変更に成功しました。'
      redirect_to admin_customers_path
    else
      flash[:alert] = '会員ステータスの変更に失敗しました。'
      render :show
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:is_active)
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

end

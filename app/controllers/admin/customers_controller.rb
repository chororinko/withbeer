class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to admin_customers_path
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:email, :user_name, :is_active)
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
  end

end

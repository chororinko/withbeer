class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!
  before_action :ensure_customer, only: [:show, :edit, :update]

  def index
    @customers = Customer.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to admin_customers_path
    else
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:is_active)
  end

  def ensure_customer
    @customer = Customer.find(params[:id])
  end

end

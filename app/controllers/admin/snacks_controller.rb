class Admin::SnacksController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customer = Customer.find(params[:customer_id])
    @snacks = @customer.snacks.page(params[:page])
  end

  def show
    @snack = Snack.find(params[:id])
    @customer = @snack.customer
    @snack_tags = @snack.tags
  end

  def edit
    @snack = Snack.find(params[:id])
  end

  def update
  end

  def destroy
    snack = Snack.find(params[:id])
    customer = snack.customer.id
    snack.destroy
    flash[:notice] = '投稿を削除しました。'
    redirect_to admin_customer_snacks_path(customer)
  end

end



class Public::CustomersController < ApplicationController

  def show
    @customer = current_customer
    @snacks = @customer.snack.all
    # @favorite = snack.favorite.count
    # @recipe_comment = snack.recipe_comment.count
  end

  def edit
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = 'プロフィールの編集に成功しました。'
      redirect_to snack_path(@snack)
    else
      flash[:notice] = 'プロフィールの編集に失敗しました。'
      render :edit
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:user_name, :introduction, :profile_image)
  end

end

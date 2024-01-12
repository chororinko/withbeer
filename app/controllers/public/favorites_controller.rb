class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!

  def create
    @snack = Snack.find(params[:snack_id])
    favorite = current_customer.favorites.new(snack_id: @snack.id)
    favorite.save
  end

  def destroy
    @snack = Snack.find(params[:snack_id])
    favorite = current_customer.favorites.find_by(snack_id: @snack.id)
    favorite.destroy
  end

end

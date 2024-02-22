class Public::FavoritesController < ApplicationController
  before_action :authenticate_customer!
  before_action :set_snack, only: [:create, :destroy]

  def create
    favorite = current_customer.favorites.new(snack_id: @snack.id)
    favorite.save
  end

  def destroy
    favorite = current_customer.favorites.find_by(snack_id: @snack.id)
    favorite.destroy
  end

  private

  def set_snack
    @snack = Snack.find(params[:snack_id])
  end

end

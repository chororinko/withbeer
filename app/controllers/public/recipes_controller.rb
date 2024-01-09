class Public::RecipesController < ApplicationController
  before_action :authenticate_customer!, except: [:index, :show]

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      flash[:notice] = 'おつまみの新規投稿に成功しました。'
      redirect_to snack_path(@snack)
    else
      flash[:notice] = 'おつまみの新規投稿に失敗しました。'
      render :new
    end
  end

  private

  def recipe_params
    params.require(:recipe).permit(:ingredients, :process, :snack_id)
  end

end

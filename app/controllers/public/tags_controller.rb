class Public::TagsController < ApplicationController

  def index
    @snacks = Snack.page(params[:snack_id])
    @tag = Tag.find(params[:id])
  end

  def new
  end

end

class Public::TagsController < ApplicationController

  def index
    @snacks = Snack.page(params[:snack_id])
    @tag = @tag.snacks
  end

  def new
  end

end

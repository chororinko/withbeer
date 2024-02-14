class SearchesController < ApplicationController

  def search
    @tags = Tag.all
    @word = params[:word]
    @snacks = Snack.looks(@word).order(created_at: :desc).page(params[:page])
    if params[:latest]
      @snacks = Snack.looks(@word).latest.page(params[:page])
    elsif params[:old]
      @snacks = Snack.looks(@word).old.page(params[:page])
    elsif params[:most_favorited]
      @snacks = Snack.looks(@word).most_favorited.page(params[:page])
    end
    render 'searches/search'
  end

end

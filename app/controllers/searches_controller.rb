class SearchesController < ApplicationController

  def search
    @tags = Tag.all
    @word = params[:word]
    @word == Snack
    @snacks = Snack.looks(@word).order(created_at: :desc).page(params[:page])
    if params[:latest]
      @snacks = @word.snacks.latest.page(params[:page])
    elsif params[:old]
      @snacks = @word.snacks.old.page(params[:page])
    elsif params[:most_favorited]
      @snacks = @word.snacks.most_favorited.page(params[:page])
    end
    render 'searches/search'
  end

end

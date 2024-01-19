class SearchesController < ApplicationController

  def search
    @tags = Tag.all
    @word = params[:word]
    @word == "Snack"
    @snacks = Snack.looks(@word).order(created_at: :desc).page(params[:page]).per(2)
    render 'searches/search'
  end

end

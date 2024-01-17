class SearchesController < ApplicationController

  def search
    @tags = Tag.all
    @word = params[:word]
    @word == "Snack"
    @snacks = Snack.looks(@word).page(params[:page])
    render 'searches/search'
  end

end

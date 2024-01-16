class SearchesController < ApplicationController

  def search
    @tags = Tag.all
    @word = params[:word]
    @word == "Snack"
    @snacks = Snack.looks(@word)
    render 'searches/search'
  end

end

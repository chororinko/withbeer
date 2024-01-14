class SearchesController < ApplicationController

  def search
		@word = params[:word]
    @word == "Snack"
    @snacks = Snack.looks(@word)
    render 'searches/search'
  end

end

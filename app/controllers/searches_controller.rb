class SearchesController < ApplicationController

  def search
		@content = params[:content]
    if @content == "Snack"
      @snacks = Snack.looks(@content, @search)
      render '/searches/search_result'
    end
  end

end

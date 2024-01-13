class Public::HomesController < ApplicationController

  def top
    @sakes = Sake.all
    @tags = Tag.all
  end

end

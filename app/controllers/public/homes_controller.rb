class Public::HomesController < ApplicationController

  def top
    @sakes = Sake.all
  end

end

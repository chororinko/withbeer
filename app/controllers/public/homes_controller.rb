class Public::HomesController < ApplicationController

  def top
    @sakes = Sake.all
    @tags = Tag.all
    @snack = Snack.where(customer_id: nil).last(1)
  end

end

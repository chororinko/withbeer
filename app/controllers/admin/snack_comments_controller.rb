class Admin::SnackCommentsController < ApplicationController

  def destroy
    @snack = Snack.find(params[:snack_id])
    @snack_comment = @snack.snack_comments.find(params[:id]).destroy
  end

end

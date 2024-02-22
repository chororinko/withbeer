class Admin::SnackCommentsController < ApplicationController

  def destroy
    snack = Snack.find(params[:snack_id])
    snack_comment = snack.snack_comments.find(params[:id]).destroy
    flash[:notice] = 'コメントを削除しました。'
    redirect_to request.referer
  end

end

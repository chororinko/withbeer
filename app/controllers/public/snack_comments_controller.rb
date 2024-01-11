class Public::SnackCommentsController < ApplicationController

  def create
    @snack = Snack.find(params[:snack_id])
    @snack_comment = current_customer.snack_comments.new(snack_comment_params)
    @snack_comment.snack_id = @snack.id
    @snack_comment.save
  end

  def destroy
    @snack = Snack.find(params[:snack_id])
    @snack_comment = current_customer.snack_comments.find(params[:id]).destroy
  end

  private

  def sanck_comment_params
    params.require(:snack_comment).permit(:comment)
  end

end
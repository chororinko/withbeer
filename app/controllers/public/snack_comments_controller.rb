class Public::SnackCommentsController < ApplicationController
  before_action :set_snack, only: [:create, :destroy]
  before_action :set_snack_comments, only: [:create, :destroy]

  def create
    @snack_comment = current_customer.snack_comments.new(snack_comment_params)
    @snack_comment.snack_id = @snack.id
    @snack_comment.save
  end

  def destroy
    @snack_comment = current_customer.snack_comments.find(params[:id]).destroy
  end

  private

  def snack_comment_params
    params.require(:snack_comment).permit(:comment)
  end

  def set_snack
    @snack = Snack.find(params[:snack_id])
  end

  def set_snack_comments
    @snack_comments = @snack.snack_comments.order(created_at: :desc).page(params[:page]).per(6)
  end

end
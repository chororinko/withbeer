class Public::HomesController < ApplicationController

  def top
    @sakes = Sake.all
    @tags = Tag.all
    @snack = Snack.where(customer_id: nil).last
    @most_favorited = Snack.find(Favorite.where(snack_id: params[:id]).group(:snack_id).order('COUNT(snack_id) desc').limit(1).pluck(:snack_id))
    # limit(1)・・・orderでいいねが多い順に並べ替えられたものの最初の1つを取得=>いいねが最も多い投稿を取得
  end

end

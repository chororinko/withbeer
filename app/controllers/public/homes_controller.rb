class Public::HomesController < ApplicationController

  def top
    @sakes = Sake.all
    @tags = Tag.all
    @snack = Snack.where(customer_id: nil).last
    @most_favorited = Snack.left_joins(:favorites).group('snacks.id').order('COUNT(favorites.id) DESC').first
    #orderでいいねが多い順に並べ替えられたものの最初の1つ(first)を取得=>いいねが最も多い投稿を取得
  end

end

class Notification < ApplicationRecord
  include Rails.application.routes.url_helpers    # モデルの中でxxx_pathメソッドを使用するために必要な記述

  belongs_to :customer
  belongs_to :notifiable, polymorphic: true

  def message
    if notifiable_type === "Favorite"
      "#{notifiable.customer.user_name}さんがあなたの投稿にいいねしました"
    else
      "#{notifiable.customer.user_name}さんがあなたの投稿にコメントしました"
    end
  end

  def notifiable_path
    if self.notifiable_type === "Favorite"
      customer_path(self.notifiable.customer.id)     # いいねに対する通知の場合はいいねをしたCustomerの詳細ページへ
    else
      snack_path(self.notifiable.snack.id)     # コメントに対する通知の場合はコメントをしたSnackの詳細ページへ
    end
  end

end

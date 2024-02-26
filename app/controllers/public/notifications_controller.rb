class Public::NotificationsController < ApplicationController
  before_action :authenticate_customer!

  def update
    notification = current_customer.notifications.find(params[:id])   # ログインしている会員に紐づく通知レコードから、指定のidのレコードを取得
    notification.update(read: true)     # 取得した通知レコードのreadカラムをtrueに更新=既読状態に変更
    redirect_to notification.notifiable_path    # 通知内容の種類に応じたリダイレクト先にリダイレクト
  end
end

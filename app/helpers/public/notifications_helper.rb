module Public::NotificationsHelper

  def unread_notifications
    @notifications = current_customer.notifications.where(read: false)
  end

end

class SnackComment < ApplicationRecord

  belongs_to :customer
  belongs_to :snack
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :comment, presence: true

  after_create do
    create_notification(customer_id: snack.customer_id)
  end

end
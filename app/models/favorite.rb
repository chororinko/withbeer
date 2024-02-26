class Favorite < ApplicationRecord

  belongs_to :customer
  belongs_to :snack
  has_one :notification, as: :notifiable, dependent: :destroy

  validates :customer_id, uniqueness: { scope: :snack_id }

  after_create do
    create_notification(customer_id: snack.customer_id)
  end

end

class Favorite < ApplicationRecord

  belongs_to :customer
  belongs_to :snack

  validates :customer_id, uniqueness: { scope: :snack_id }

end

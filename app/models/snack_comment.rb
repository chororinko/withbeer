class SnackComment < ApplicationRecord

  belongs_to :customer
  belongs_to :snack

  validates :comment, presence: true

  # コメントの表示件数
  paginates_per 1

end
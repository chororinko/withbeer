class SnackComment < ApplicationRecord

  belongs_to :customer
  belongs_to :snack

end
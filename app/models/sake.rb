class Sake < ApplicationRecord

  has_many :snacks, dependent: :destroy

end

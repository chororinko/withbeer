class Sake < ApplicationRecord

  has_many :snacks, dependent: :destroy
  has_many :recommendations, dependent: :destroy

  validates :genre, presence: true, uniqueness: true

end

class Tag < ApplicationRecord

  has_many :snack_tags, dependent: :destroy
  has_many :snacks, through: :snack_tags

  validates :name, uniqueness: true
end

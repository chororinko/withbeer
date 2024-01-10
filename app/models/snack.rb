class Snack < ApplicationRecord

  belongs_to :customer
  belongs_to :sake

  has_many :snack_tags, dependent: :destroy
  has_many :tags, through: :snack_tags

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

  def self.looks(content, search)
    if search == "perfect_match"
      Snack.where("title LIKE?", "#{content}")
    elsif search == "forward_match"
      Snack.where("title LIKE?", "#{content}%")
    elsif search == "backward_match"
      Snack.where("title LIKE?", "%#{content}")
    else
      Snack.where("title LIKE?", "%#{content}%")
    end
  end
end

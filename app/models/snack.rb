class Snack < ApplicationRecord

  belongs_to :customer, optional: true
  belongs_to :sake

  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_many :snack_tags, dependent: :destroy
  has_many :tags, through: :snack_tags
  has_many :snack_comments, dependent: :destroy
  has_many :recommendations, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :ingredients
    validates :process
    validates :sake_id
  end
  validates :introduction, presence: true, length: { maximum: 200 }

  # 1つの投稿に対して1人1回までしかいいねできないようにするための確認メソッド
  def favorited_by?(customer)
    if customer.instance_of?(Customer)
      favorites.exists?(customer_id: customer.id)
    else
      false
    end
  end

  has_one_attached :image

  def get_image(width, height)
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      image.variant(resize_to_limit: [width, height]).processed
  end

  def self.looks(word)
    if word == "perfect_match"
      Snack.where("title LIKE?", "#{word}")
    elsif word == "forward_match"
      Snack.where("title LIKE?", "#{word}%")
    elsif word == "backward_match"
      Snack.where("title LIKE?", "%#{word}")
    else
      Snack.where("title LIKE?", "%#{word}%")
    end
  end

  def save_tags(tags)
    # 既にタグあるなら全取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?

    # 共通要素取り出し
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # 古いタグ削除
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name: old_name)
    end

    # 新しいタグ作成
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name: new_name)
      self.tags << tag
    end
  end

end

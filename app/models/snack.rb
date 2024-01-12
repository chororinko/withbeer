class Snack < ApplicationRecord

  belongs_to :customer
  belongs_to :sake

  has_many :favorites, dependent: :destroy
  has_many :favorited_customers, through: :favorites, source: :customer
  has_many :snack_tags, dependent: :destroy
  has_many :tags, through: :snack_tags
  has_many :snack_comments, dependent: :destroy

  def favorited_by?(customer)
    if customer.instance_of?(Customer)
      favorites.exists?(customer_id: customer.id)
    else
      false
    end
  end

  def self.favorited_snacks(customer, page)    # 1. モデル内での操作を開始
    includes(:favorites)                                 # 2. favorites テーブルを結合
      .where(favorites: { customer_id: customer.id })    # 3. ユーザーがいいねしたレコードを絞り込み
      .order(created_at: :desc) # 4. 投稿を作成日時の降順でソート
      .page(page) # 5. ページネーションのため、指定ページに表示するデータを選択
  end

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

class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :snacks, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :snack_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :user_name, presence: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/noimage.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
      profile_image.variant(resize_to_limit: [width, height]).processed
  end

  GUEST_USER_EMAIL = "guest@example.com"

  def self.guest
    find_or_create_by!(email: GUEST_USER_EMAIL) do |customer|    # 指定したアドレスが見つからなければ新規作成する
      customer.password = SecureRandom.urlsafe_base64     # パスワードをランダムで作成する
      customer.user_name = 'guestuser'
    end
  end

  def guest_user?
    email == GUEST_USER_EMAIL
  end

end

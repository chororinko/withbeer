class Recommendation < ApplicationRecord

  belongs_to :snack
  belongs_to :sake

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

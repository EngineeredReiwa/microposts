class Micropost < ApplicationRecord
  belongs_to :user

  validates :content, presence: true, length: { maximum: 255 }
  has_many :favoriteds, class_name: 'Favorite', foreign_key: 'micropost_id'
  has_many :favoritedbys, through: :favorites, source: :user
  
  def favorited(user)
    unless self == user
      self.favoriteds.find_or_create_by(user_id: user.id)
    end
  end

  def unfavorited(user)
    favorited = self.favoriteds.find_by(user_id: user.id)
    favorited.destroy if favorited
  end

  def favoriteding?(user)
    self.favoritedbys.include?(user)
  end
end
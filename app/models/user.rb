class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :photos
  has_many :comments

  has_many :votes, dependent: :destroy
  has_many :voted_photos, through: :votes, source: :photo

  with_options presence: true do
    validates :nickname, uniqueness: { case_sensitive: true }
    # パスワードは半角英数字混合での入力が必須
    PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
    validates :password, format: { with: PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください' }
  end


  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationships', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  def following?(other_user)
    self.followings.include?(other_user)
  end

  def votable_for?(photo)
    photo && photo.user != self && !votes.exists?(photo_id: photo.id)
  end

  def deletable_vote?(photo)
    photo && photo.user != self && votes.exists?(photo_id: photo.id)
  end

end

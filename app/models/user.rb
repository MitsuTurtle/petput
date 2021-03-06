class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :photos, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_photos, through: :favorites, source: :photo

  has_many :votes, dependent: :destroy
  has_many :voted_photos, through: :votes, source: :photo

  has_one_attached :avatar

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy

  # NICKNAME_REGEX = /[a-zA-Z0-9_]{4,15}/.freeze
  with_options presence: true do
    validates :nickname, uniqueness: { case_sensitive: true }, length: { maximum: 15 }
    validates :avatar, presence: { message: 'を選択してください' }
  end

  # 新規登録時のみの設定にしています。もし、登録更新時にパスワード更新も可能にするならば、on: :createを外すなど修正が必要です。
  # パスワードは半角英数字混合での入力が必須
  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  validates :password, presence: true, format: { with: PASSWORD_REGEX, message: 'は半角英数字混合で入力してください' }, on: :create

  validates :profile, length: { maximum: 160 }

  def follow(other_user)
    relationships.find_or_create_by(follow_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    relationship = relationships.find_by(follow_id: other_user.id)
    relationship.destroy
  end

  def following?(other_user)
    followings.include?(other_user)
  end

  def votable_for?(photo)
    photo && photo.user != self && !votes.exists?(photo_id: photo.id)
  end

  def deletable_for?(photo)
    photo && photo.user != self && votes.exists?(photo_id: photo.id)
  end

  # フォローの通知メソッド
  def create_follow_notification_by(current_user)
    temp = Notification.where(['visitor_id = ? and visited_id = ? and action = ? ', current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  # ゲストユーザー
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.hex(5)
      user.nickname = 'ゲスト'
      user.avatar.attach(io: File.open(Rails.root.join('app/assets/images/guest_avatar.png')), filename: 'guest_avatar.png')
    end
  end
end

class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :photo_hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :photo_hashtag_relations

  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  has_many :favorites, dependent: :destroy
  has_many :favorite_users, through: :favorites, source: :user

  has_many :notifications, dependent: :destroy

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :image
    validates :caption
    validates :category_id, numericality: { other_than: 0 }
  end

  # DBへのコミット直前に実施する
  after_create do
    photo = Photo.find_by(id: id)
    hashtags = caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    photo.hashtags = []
    hashtags.uniq.map do |hashtag|
      # ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      photo.hashtags << tag
    end
  end

  before_update do
    photo = Photo.find_by(id: id)
    photo.hashtags.clear
    hashtags = caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      photo.hashtags << tag
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # いいねの通知メソッド
  def create_like_notification_by(current_user)
    notification = current_user.active_notifications.new(
      photo_id: id,
      visited_id: user_id,
      action: "like"
    )
    notification.save if notification.valid?
  end

  # コメントの通知メソッド（自分のコメントは通知しないことにする）
  def create_comment_notification_by(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(photo_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_comment_notification(current_user, comment_id, temp_id['user_id'])
    end

    # 写真投稿者がコメントしていなければ投稿者にも通知を送る
    if current_user.id != user_id && !temp_ids.find_by(user_id: user_id).present?
      save_comment_notification(current_user, comment_id, user_id)
    end
    
    # まだ誰もコメントしていない場合は、投稿者に通知を送る（上のコードでカバーされている）
    # save_comment_notification(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_comment_notification(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      photo_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする→通知しないこととするので下記はコメントアウト
    # if notification.visitor_id == notification.visited_id
    #   notification.checked = true
    # end
    notification.save if notification.valid?
  end
end

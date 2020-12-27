class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments, dependent: :destroy
  has_many :photo_hashtag_relations
  has_many :hashtags, through: :photo_hashtag_relations
  
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :image
    validates :caption
    validates :category_id, numericality: { other_than: 0 }
  end

  #DBへのコミット直前に実施する
  after_create do
    photo = Photo.find_by(id: self.id)
    hashtags  = self.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    photo.hashtags = []
    hashtags.uniq.map do |hashtag|
      #ハッシュタグは先頭の'#'を外した上で保存
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      photo.hashtags << tag
    end
  end
 
  before_update do 
    photo = Photo.find_by(id: self.id)
    photo.hashtags.clear
    hashtags = self.caption.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      photo.hashtags << tag
    end
  end

end

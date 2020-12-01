class Photo < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  has_many :comments

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category

  with_options presence: true do
    validates :image
    validates :caption
    validates :category_id, numericality: { other_than: 0 }
  end
end

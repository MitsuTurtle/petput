class Message < ApplicationRecord
  belongs_to :user
  belongs_to :room

  has_one_attached :dm_image

  has_many :notifications, dependent: :destroy

  validates :content, presence: true, unless: :was_attached?

  def was_attached?
    dm_image.attached?
  end
end

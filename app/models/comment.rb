class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :photo
  has_one :notifications, dependent: :destroy

  validates :text, presence: true
end

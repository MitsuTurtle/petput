class Notification < ApplicationRecord
  belongs_to :photo, optional: true
  belongs_to :comment, optional: true
  belongs_to :visitor, class_name: 'User'
  belongs_to :visited, class_name: 'User'
  belongs_to :room, optional: true
  belongs_to :message, optional: true
end

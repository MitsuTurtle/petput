class Notification < ApplicationRecord
  belongs_to :photo, optional: true
  belongs_to :comment, optional: true
  belongs_to :visiter, class_name: "User"
  belongs_to :visited, class_name: "User"
end

class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :photo

  validate do
    unless user && user.votable_for?(photo)
      errors.add(:base, :invalid)
    end
  end
end

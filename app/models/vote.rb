class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :photo

  validate do
    errors.add(:base, :invalid) unless user&.votable_for?(photo)
  end
end

class Favorite < ApplicationRecord
  belongs_to :ad
  belongs_to :user
  validates :ad_id, uniqueness: { scope: :user_id, message: 'already a Favorite' }
end

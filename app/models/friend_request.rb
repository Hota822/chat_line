class FriendRequest < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :request_user_id, presence: true
end

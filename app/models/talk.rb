class Talk < ApplicationRecord
  belongs_to :user
  belongs_to :talk_room
  default_scope -> { order(created_at: :desc) }
end

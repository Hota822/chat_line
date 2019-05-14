class AddIndexToFriendRequests < ActiveRecord::Migration[5.2]
  def change
    add_index :friend_requests, [:user_id, :request_user_id], unique: true
  end
end

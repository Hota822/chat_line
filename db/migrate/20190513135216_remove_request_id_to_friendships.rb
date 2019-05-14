class RemoveRequestIdToFriendships < ActiveRecord::Migration[5.2]
  def change
    remove_index :friendships, [:user_id, :request_id]
    remove_column :friendships, :request_id
  end
end

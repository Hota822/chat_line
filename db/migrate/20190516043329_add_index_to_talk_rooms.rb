class AddIndexToTalkRooms < ActiveRecord::Migration[5.2]
  def change
    add_index :talk_rooms, :updated_at
  end
end

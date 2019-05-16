class AddColumnToTalkRooms < ActiveRecord::Migration[5.2]
  def change
    add_column :talk_rooms, :group_talk, :boolean, default: false, null: false

  end
end

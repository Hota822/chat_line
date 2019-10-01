class AddColumnToTalk < ActiveRecord::Migration[5.2]
  def change
    add_column :talks, :talk_room_id, :integer
  end
end

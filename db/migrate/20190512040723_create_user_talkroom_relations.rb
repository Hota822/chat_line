class CreateUserTalkroomRelations < ActiveRecord::Migration[5.2]
  def change
    create_table :user_talkroom_relations do |t|
      t.references :user, foreign_key: true
      t.references :talk_room, foreign_key: true

      t.timestamps
    end
    add_index :user_talkroom_relations, [:user_id, :talk_room_id]
  end
end

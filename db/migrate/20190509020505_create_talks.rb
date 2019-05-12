class CreateTalks < ActiveRecord::Migration[5.2]
  def change
    create_table :talks do |t|
      t.references :user, foreign_key: true
      t.text :content

      t.timestamps
    end
    add_index :talks, [:user_id, :created_at]
  end
end

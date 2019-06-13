class ChangeDatatypeContentOfTalks < ActiveRecord::Migration[5.2]
  def change
    change_column :talks, :content, :text
  end
end

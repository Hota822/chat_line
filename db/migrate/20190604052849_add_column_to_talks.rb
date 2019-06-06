class AddColumnToTalks < ActiveRecord::Migration[5.2]
  def change
    add_column :talks, :content_type, :string, default: 'message'
  end
end

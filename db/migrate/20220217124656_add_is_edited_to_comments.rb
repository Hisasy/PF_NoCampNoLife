class AddIsEditedToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :is_edited, :boolean, default: false, null: false
  end
end

class AddIsAdminEditedToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :is_admin_edited, :boolean, default: false, null: false
  end
end

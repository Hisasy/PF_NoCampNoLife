class RemoveIsAdminEditedFromAdmins < ActiveRecord::Migration[5.2]
  def change
    remove_column :admins, :is_admin_edited, :boolean
  end
end

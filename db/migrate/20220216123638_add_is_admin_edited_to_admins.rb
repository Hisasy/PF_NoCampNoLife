class AddIsAdminEditedToAdmins < ActiveRecord::Migration[5.2]
  def change
    add_column :admins, :is_admin_edited, :boolean
    
  end
end

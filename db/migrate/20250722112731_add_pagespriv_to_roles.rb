class AddPagesprivToRoles < ActiveRecord::Migration[8.0]
  def change
    add_column :roles, :pagespriv, :boolean
  end
end

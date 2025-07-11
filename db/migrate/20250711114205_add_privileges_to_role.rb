class AddPrivilegesToRole < ActiveRecord::Migration[8.0]
  def change
    add_column :roles, :panelpriv, :boolean
    add_column :roles, :postspriv, :boolean
    add_column :roles, :rolespriv, :boolean
    add_column :roles, :userspriv, :boolean
  end
end

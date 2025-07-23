class AddInNavToPages < ActiveRecord::Migration[8.0]
  def change
    add_column :pages, :in_nav, :boolean
  end
end

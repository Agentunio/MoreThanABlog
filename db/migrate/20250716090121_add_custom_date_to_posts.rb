class AddCustomDateToPosts < ActiveRecord::Migration[8.0]
  def change
    add_column :posts, :custom_date, :date
  end
end

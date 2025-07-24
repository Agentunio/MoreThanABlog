class RemoveSatusFromPdf < ActiveRecord::Migration[8.0]
  def change
    remove_column :pdfs, :status, :integer
  end
end

class CreatePdfs < ActiveRecord::Migration[8.0]
  def change
    create_table :pdfs do |t|
      t.text :url
      t.integer :status

      t.timestamps
    end
  end
end

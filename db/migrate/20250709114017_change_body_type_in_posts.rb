class ChangeBodyTypeInPosts < ActiveRecord::Migration[8.0]
  def change
    change_column :posts, :body, :text
  end
end

class AddStatusToBlogPosts < ActiveRecord::Migration[7.1]
  def change
    add_column :blog_posts, :status, :string
  end
end

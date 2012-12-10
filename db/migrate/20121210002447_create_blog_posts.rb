class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.string :permalink
      t.datetime :published_at
      t.boolean :published
      t.text :content_markdown
      t.integer :user_id

      t.timestamps
    end
  end
end

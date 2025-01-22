class CreateBlogPosts < ActiveRecord::Migration[7.0]
  def change
    create_table :blog_posts do |t|
      t.integer :blog_subject_id
      t.string :title
      t.text :content
      t.string :image
      t.string :video

      t.timestamps
    end
  end
end

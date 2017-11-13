require 'active_record'

class AddBlogPosts < ActiveRecord::Migration[4.2]
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :html_text
      t.datetime :posted_date
    end
  end
end
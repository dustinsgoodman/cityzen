class CreateForums < ActiveRecord::Migration
  def up
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.integer :user_id
      t.integer :petition_id
      t.integer :legistlation_id

      t.timestamps
    end

    create_table :comments do |t|
      t.integer :user_id
      t.string :content
      t.integer :post_id

      t.timestamps
    end

    create_table :sub_comments do |t|
      t.integer :comment_id
      t.integer :user_id
      t.string :content

      t.timestamps
    end
  end

  def drop
    drop_table :posts
    drop_table :comments
    drop_table :sub_comments
  end
end

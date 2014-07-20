class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url
      t.string :title
      t.text :body
      t.references :feed

      t.timestamps
    end
  end
end

class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url, null: false, default: ''
      t.string :title, null: false, default: ''
      t.text :body, null: false, default: ''
      t.references :feed, index: true

      t.timestamps
    end
  end
end

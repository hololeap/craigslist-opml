class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :path
      t.string :type

      t.string :post_title_regex
      t.string :post_title_matches

      t.references :category

      t.timestamps
    end
  end
end

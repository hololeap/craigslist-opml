class AddPostTitleRegexToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :post_title_regex, :string
    add_column :categories, :post_title_matches, :string
  end
end

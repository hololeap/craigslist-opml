class CreateCategoriesSearchFields < ActiveRecord::Migration
  def change
    create_table :categories_search_fields do |t|
      t.references :category
      t.references :search_field
    end
  end
end

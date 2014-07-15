class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name, null: false, default: ''
      t.string :path
      t.string :type
      t.belongs_to :category, index: true

      t.timestamps
    end
  end
end

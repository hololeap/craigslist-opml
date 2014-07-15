class CreateSearchOptions < ActiveRecord::Migration
  def change
    create_table :search_options do |t|
      t.string :name
      t.integer :order
      t.belongs_to :search_select, index: true

      t.timestamps
    end
  end
end

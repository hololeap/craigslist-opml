class CreateSearchOptions < ActiveRecord::Migration
  def change
    create_table :search_options do |t|
      t.string :name
      t.integer :order
      t.references :search_select

      t.timestamps
    end
  end
end

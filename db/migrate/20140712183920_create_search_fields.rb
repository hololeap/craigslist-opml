class CreateSearchFields < ActiveRecord::Migration
  def change
    create_table :search_fields do |t|
      t.string :name
      t.string :search_attribute
      t.references :field, polymorphic: true

      t.timestamps
    end
  end
end

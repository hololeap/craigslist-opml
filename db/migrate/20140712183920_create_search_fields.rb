class CreateSearchFields < ActiveRecord::Migration
  def change
    create_table :search_fields do |t|
      t.string :name
      t.belongs_to :category, index: true
      t.belongs_to :field, polymorphic: true, index: true

      t.timestamps
    end
  end
end

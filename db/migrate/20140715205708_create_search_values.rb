class CreateSearchValues < ActiveRecord::Migration
  def change
    create_table :search_values do |t|
      t.string :value
      t.references :search_field, index: true
      t.references :feed, index: true

      t.timestamps
    end
  end
end

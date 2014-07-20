class CreateSearchValues < ActiveRecord::Migration
  def change
    create_table :search_values do |t|
      t.string :value

      t.references :search_field
      t.references :feed
      t.references :feed_aggregator

      t.timestamps
    end
  end
end

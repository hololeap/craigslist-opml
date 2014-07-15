class CreateFeedAggregators < ActiveRecord::Migration
  def change
    create_table :feed_aggregators do |t|
      t.string :name
      t.text :last_xml

      t.timestamps
    end
  end
end

class CreateFeedsFeedAggregators < ActiveRecord::Migration
  def change
    create_table :feeds_feed_aggregators do |t|
      t.references :feed, index: true
      t.references :feed_aggregator, index: true
    end
  end
end

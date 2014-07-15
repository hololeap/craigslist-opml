class FeedAggregator < ActiveRecord::Base
  has_and_belongs_to_many :feeds
end

class FeedAggregator < ActiveRecord::Base
  has_many :search_values
  has_many :feeds, through: :search_values

  def self.create_from(cities, categories, name = nil)
    feeds, search_values = [], []
    cities.each do |city|
      categories.each do |category|
        feeds << feed = Feed.find_or_create_from(city, category, false)
        category.search and category.search.each do |search_field, hash|
          value = hash.values.join(',') # This will only work with Text and Range search types
          search_values << SearchValue.find_or_create_by!(value: value, search_field: search_field, feed: feed)
        end
      end
    end

    unless feed_aggregator = all.find {|fa| search_values | fa.search_values == search_values }
      feed_aggregator = FeedAggregator.create! name: (name || "Feed Aggregator ##{count + 1}")
      feed_aggregator.search_values += search_values
    end

    feed_aggregator
  end

  def generate_xml
    feeds = self.feeds.map do |feed| 
      search_values = self.search_values.where(feed: feed)
      feed.check_for_updates(search_values, false)
    end
    updated_feeds, stale_feeds = feeds.partition {|rss, new_items| new_items }
    
    if updated_feeds.empty?
      return last_xml if last_xml

      first = stale_feeds.pop.first
      first.items.delete_if { true }
    else
      first = updated_feeds.pop.first
      updated_feeds.each {|rss, new_items| rss.items.each {|item| first.items << item } }
    end

    update! last_xml: first.to_feed('atom') { |maker|
      maker.channel.updated = Time.now
      maker.channel.author = 'Craigslist'
    }.to_xml

    last_xml
  end
end

json.array!(@feed_aggregators) do |feed_aggregator|
  json.extract! feed_aggregator, :id
  json.url feed_aggregator_url(feed_aggregator, format: :json)
end

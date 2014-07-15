json.array!(@feeds) do |feed|
  json.extract! feed, :id, :feed_url, :range_min, :range_max, :search_string
  json.url feed_url(feed, format: :json)
end

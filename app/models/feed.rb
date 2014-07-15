require 'rss'

class Feed < ActiveRecord::Base
  belongs_to :category
  belongs_to :city
  has_many :posts
  has_and_belongs_to_many :feed_aggregators

  def check_for_updates
    rss = RSS::Parser.parse(url)
    if new_items?(rss)
      filter_items(rss)
      return [rss, new_matching_items?(rss)]
    end
    [rss, false]
  end

  def self.create_from(city, category, opts = {})
    self.create! opts.merge(city: city, category: category, url: category.xml_url(city))
  end

  private

  def new_items?(rss)
    if rss.items.first and last_url.nil? or rss.items.first.link != last_url
      update! last_url: rss.items.first.link
      true
    else
      false
    end
  end

  def new_matching_items?(rss)
    if rss.items.first and last_matching_url.nil? or rss.items.first.link != last_matching_url
      update! last_matching_url: rss.items.first.link
      true
    else
      false
    end
  end

  def filter_items(rss)
    rss.items.delete_if do |item|
      post = search_string ? Post.find_by_url(item.link) : Post.new(title: item.title)

      unless post
        ad = Craigslist::Ad.new(item.link)
        post = Post.create! url: item.link, title: ad.title, body: ad.body, price: ad.price
      end
      post.update! feed: self
      !meets_criteria?(post)
    end
  end

  def meets_criteria?(post)
    if post.price
      return false if range_min and post.price < range_min
      return false if range_max and post.price > range_max
    end
    return false if search_string and not post.contains? search_string
    true
  end
end

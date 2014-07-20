require 'rss'

class Feed < ActiveRecord::Base
  belongs_to :category
  belongs_to :city
  has_many :posts
  has_many :search_values

  def check_for_updates(search_values = nil, include_search_query = true)
    search_values ||= self.search_values
    
    # We need to filter out invalid UTF-8
    string = open(url).read
    string.encode!('UTF-8', 'binary', invalid: :replace, undef: :replace, replace: '')

    rss = RSS::Parser.parse(string)
    if new_items?(rss)
      filter_items(rss, search_values)
      return [rss, new_matching_items?(rss)]
    end
    [rss, false]
  end

  def self.create_from(city, category, include_search_query = true, opts = {})
    self.create! opts.merge(city: city, 
                            category: category, 
                            url: category.xml_url(city, include_search_query))
  end

  def self.find_or_create_from(city, category, include_search_query = true, opts = {})
    feed = find_by_url category.xml_url(city, include_search_query)
    feed ||= create_from(city, category, include_search_query, opts)
  end

  private

  def new_items?(rss)
    if rss.items.first and (last_url.nil? or rss.items.first.link != last_url)
      update! last_url: rss.items.first.link
      true
    else
      false
    end
  end

  def new_matching_items?(rss)
    if rss.items.first and (last_matching_url.nil? or rss.items.first.link != last_matching_url)
      update! last_matching_url: rss.items.first.link
      true
    else
      false
    end
  end

  def filter_items(rss, search_values)
    rss.items.delete_if do |item|
      if search_values.any? {|sv| sv.search_field.field_type == 'SearchTypes::Text' }
        post = Post.find_by_url item.link
        post.feed = self if post
      else
        post = Post.new title: item.title, url: item.link, feed: self
      end

      unless post
        ad = Craigslist::Ad.new(item.link)
        post = Post.create! url: item.link, title: ad.title, body: ad.body, feed: self
      end

      not meets_criteria?(post, search_values)
    end
  end

  def meets_criteria?(post, search_values)
    search_values.all? {|sv| sv.matching_data? post }
  end
end

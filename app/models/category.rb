class Category < ActiveRecord::Base
  attr_reader :search

  def add_search(search)
    return if search.nil? or search.empty?
    @search ||= {}
    search.each do |field_id, hash|
      field = SearchField.find(field_id)
      raise "No such SearchField with id of #{field_id}" unless field
      @search.merge!(field => hash)
    end
  end

  def search_query(other = {})
    return nil if @search.nil? and other.empty?
    search = @search || {}

    hash = search.values.inject({}, :merge)
    hash.merge!(other)
    hash.delete_if {|k,v| v.nil? or v.empty?}
    hash.empty? ? nil : URI.encode_www_form(hash)
  end

  def http_url(city)
    if query = search_query
      search_path = "/search/"
      search_path += "#{city.abbrev}/" if city.is_a? Subcity
      uri = city.uri + search_path
      uri.query = query
    else
      uri = city.uri + "#{path}/"
    end
    uri.to_s
  end

  def xml_url(city)
    if search_query
      uri = URI(http_url(city))
      uri.query = search_query(format: :rss)
    else
      uri = http_url(city) + "index.rss"
    end
    uri.to_s
  end

  def match(string, name)
    raise "No regex defined in category" unless post_title_regex and post_title_matches
    matches = Hash[*post_title_matches.split(',')]
    raise "No such index defined for category title: #{name}" unless matches[name]
    Regexp.new(post_title_regex).match(string)[matches[name].to_i]
  end

  has_many :subcategories
  has_many :search_fields
  has_many :feeds

  validates :path, uniqueness: true, allow_nil: true

  alias :children :subcategories
  
  def has_children?
    subcategories.count > 0
  end
  
  def xml_path
    path + '/index.rss'
  end

  def self.roots
    where(type: nil).order(:id)
  end

  def self.tree
    Hash[*categories.inject([]) do |a,category|
      a << category
      a << category.subcategories
    end]
  end
end

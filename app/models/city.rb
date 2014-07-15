class City < ActiveRecord::Base
  belongs_to :subregion, class_name: 'Subregion', foreign_key: 'region_id'
  has_many :subcities
  has_many :categories
  has_many :feeds
  
  alias :children :subcities
  
  def has_children?
    subcities.count > 0
  end

  def uri
    URI(url)
  end

  def uri=(uri)
    self.url = uri.to_s
  end

  def self.tree
    Hash[*Region.all.inject([]) do |a, region|
      a << region
      a << Hash[*region.subregions.inject([]) do |b, subregion|
        b << subregion
        b << subregion.cities
      end]
    end]
  end
end

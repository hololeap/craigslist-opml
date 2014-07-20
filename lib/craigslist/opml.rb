module Craigslist::OPML
  def self.create(cities, categories)
    directory = city_directory(cities)
    ::OPML.new('Craigslist OPML') do |xml|
      xml.outline text: 'Craigslist' do 
        if categories.size == 1
          category = categories.first
          category_name = category.name
          category_name = "#{category.category.name} / " + category_name if category.is_a? Subcategory

          xml.outline text: category_name do 
            inverted_outline directory, categories.first, xml
          end
        else
          outline directory, categories, xml
        end
      end
    end
  end
  
  def self.city_directory(cities, include_singles = false)
    subregions = cities.map(&:subregion).uniq
    regions = subregions.map(&:region).uniq
    
    directory = regions.map do |region|
      subs = subregions.find_all {|s| s.region_id == region.id}
      subs.map! do |subregion|
        cits = cities.find_all {|c| c.region_id == subregion.id}
        [subregion, cits]
      end
      [region, subs]
    end
    
    include_singles ? directory : remove_singles(directory)
  end
  
  def self.category_directory(categories, include_singles = false)
    subcategories, main_categories = categories.select(&:path).partition(&:type) 

    directory = subcategories.map(&:category).uniq.map do |category|
      subcats = subcategories.find_all {|s| s.category_id == category.id}
      [category, subcats]
    end
    directory += main_categories

    include_singles ? directory : remove_singles(directory)
  end
  
  def self.outline(directory, categories, xml)
    if directory.first.is_a? Array
      directory.each do |obj, dir|
        xml.outline text: obj.name do
          outline(dir, categories, xml)
        end
      end
    elsif directory.first.is_a? City
      directory.each do |city|
        xml.outline text: city.name do
          category_outline(category_directory(categories), xml, city)
        end
      end
    end
  end

  def self.inverted_outline(directory, category, xml)
    if directory.first.is_a? Array
      directory.each do |obj, dir|
        xml.outline text: obj.name do
          inverted_outline(dir, category, xml)
        end
      end
    elsif directory.first.is_a? City
      directory.each do |city|
        xml.outline text: city.name,
                    type: 'rss',
                    httpUrl: category.http_url(city),
                    xmlUrl: category.xml_url(city)
      end
    end
  end
  
  def self.category_outline(directory, xml, city)
    directory.each do |obj|
      if obj.is_a? Array
        category, subcategories = obj
        xml.outline text: category.name do
          category_outline(subcategories, xml, city)
        end
      elsif obj.is_a? Category
        category = obj
        text = category.name
        xml.outline text: text, 
                    type: 'rss', 
                    httpUrl: category.http_url(city), 
                    xmlUrl: category.xml_url(city)
      end
    end 
  end
  
  def self.remove_singles(directory)
    while directory.size == 1 and directory.first.is_a? Array
      directory = directory.first.last
    end
    directory
  end
end

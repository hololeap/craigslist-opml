# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

begin
m = Mechanize.new
m.max_history = 1

sfbay = nil

Craigslist::HomePage.parse(m).with_progress('Adding regions') do |region|
  r = Region.create! name: region.name
  region.children.with_progress('Adding subregions') do |subregion|
    s = r.subregions.create! name: subregion.name
    subregion.children.with_progress('Adding cities') do |city|
      c = s.cities.create! name: city.name, url: city.uri.to_s
      sfbay = c if c.name == 'san francisco bay area'
    end
  end
end

subcities = []

City.all.sort_by {|c| c == sfbay ? -1 : c.id }.with_progress('Fetching cities') do |city|
  Progress.note = city.url

  page = Craigslist.get_and_retry(m, city.url)
  subs = Craigslist::CityPage.get_subcities(page)
    
  subs.each do |subcity|
    subcities << city.subcities.create!(name: subcity.name, url: subcity.uri.to_s)
  end
end

categories = {}
page = Craigslist::CityPage.parse(m, sfbay.url)

page.categories.with_progress('Parsing categories') do |category|

  # Forums have no RSS and need to be skipped
  next if category.path == 'forums'

  if categories[category.path]
    c = categories[category.path][:object]
  else
    c = Category.new name: category.name, path: category.path
    next unless c.save
    categories[category.path] = { object: c, children: {} }
  end
  children = categories[category.path][:children]

  category.children.each do |subcategory|
    
    # There are some links within portals that are both
    unless sc = children[subcategory.path]
      sc = c.subcategories.new name: subcategory.name, path: subcategory.path
      next unless c.save
      children[subcategory.path] = sc
    end
  end
end
rescue => e
binding.pry
raise e
end

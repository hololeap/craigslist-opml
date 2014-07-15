class AddAbbrevToCities < ActiveRecord::Migration
  def change 
    add_column :cities, :abbrev, :string
    reversible do |dir|
      dir.up do
        break if City.first.url.empty? # Don't run these if the DB hasn't been populated
        subcities, cities = City.all.partition(&:type)
        subcities.each {|s| s.update! abbrev: s.uri.path.gsub('/','') }
        cities.each {|c| c.update! abbrev: c.uri.host[/^([^.]+)/,1] }
      end
    end
  end

end

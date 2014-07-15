module Craigslist::CityPage
  def self.parse(mechanize, uri)
    page = Craigslist.get_and_retry(mechanize, uri)
    OpenStruct.new subcities: get_subcities(page),
                   categories: get_categories(mechanize, page)
  end
  
  def self.get_subcities(page)
    page.search('#topban/span.sublinks/a').map do |link|
      OpenStruct.new name: link['title'],
                     uri: page.uri + link['href']
    end
  end
  
  def self.get_categories(mechanize, page)
    page.search('#main/tr/td/div.col').map do |div|
      header = div.at('h4.ban')
      header_link = header.at('a')
      OpenStruct.new name: header.text,
                     path: header_link && Craigslist.process_path(header_link['href']),
                     children: self.parse_subcategory_div(mechanize, page, div.at('div.cats'))
    end
  end
  
  def self.parse_subcategory_div(mechanize, page, div)
    non_empty_links = div.search('ul/li/a').reject {|a| a.text.empty? }
    portal_links, links = non_empty_links.partition {|a| contains_portal? a['href']}
    
    links.map! do |link|
      OpenStruct.new name: link.text,
                     path: Craigslist.process_path(link['href'])
    end
    
    portal_links.inject(links) do |array, link|
      array + Craigslist::PortalPage.parse(mechanize, page, link)
    end
  end

  private
  
  # Paths that begin with "i/" are portals to confirm age, alert about scams,
  # etc. You have to open these pages and extract the links.
  def self.contains_portal?(path)
      true & (path =~ /^\/i/)
  end
end

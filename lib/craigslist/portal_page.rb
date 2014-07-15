module Craigslist::PortalPage
  def self.parse(mechanize, page, portal_link)
    portal_page = Craigslist.get_and_retry(mechanize, page.uri + portal_link['href'])
    links = portal_page.search('section.body//:not(aside)/a').select {|l| relative_path? l['href'] }
    
    links.map do |link|
      name = portal_link.text == link.text ? portal_link.text : portal_link.text + ' - ' + link.text
      OpenStruct.new name: name.downcase,
                     path: Craigslist.process_path(link['href'])
    end
  end
  
  def self.relative_path?(path)
    URI(path).relative?
  end
end
module Craigslist::HomePage
  URI = URI('https://www.craigslist.org/about/sites')

  def self.parse(mechanize)
    page = Craigslist.get_and_retry(mechanize, URI)

    headers = page.search('section.body/h1')
    divs = page.search('section.body/h1 + div.colmask')
  
    headers.zip(divs).map do |header, div|
      OpenStruct.new name: header.text,
                     children: parse_subregion_div(div)
    end
  end

  def self.parse_subregion_div(div)
    headers = div.search('div.box/h4')
    uls = div.search('div.box/h4 + ul')

    headers.zip(uls).map do |header, ul|
      OpenStruct.new name: header.text,
                     children: parse_city_ul(ul)
    end
  end

  def self.parse_city_ul(ul)
    ul.search('li/a').map do |link|
      OpenStruct.new name: link.text,
                     uri: URI + link['href']
    end
  end
end

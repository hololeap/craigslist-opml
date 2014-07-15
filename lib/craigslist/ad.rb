class Craigslist::Ad
  def initialize(path)
    @mechanize = Mechanize.new {|m| m.max_history = 1 }
    @page = @mechanize.get path
  end

  def title
    @page.at('.postingtitle').text.strip
  end

  def price
    title[/- \$(\d+)/,1].to_f
  end

  def body
    @page.at('#postingbody').text.strip
  end

  def contains?(text)
    [title, body].any? {|x| x.downcase.include? text.downcase }
  end
end

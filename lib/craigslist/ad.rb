class Craigslist::Ad
  def initialize(path)
    @mechanize = Mechanize.new {|m| m.max_history = 1 }
    @page = @mechanize.get path
  end

  def title
    @page.at('.postingtitle').text.strip rescue ''
  end

  def body
    @page.at('#postingbody').text.strip rescue ''
  end

  def contains?(text)
    [title, body].any? {|x| x.downcase.include? text.downcase }
  end
end

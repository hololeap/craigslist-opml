class OPML < Nokogiri::XML::Builder
  def initialize(title = 'OPML', &blk)
    super do |xml|
      xml.opml version: '2.0' do
        xml.head do
          xml.title title
          xml.dateCreated Time.now.strftime('%a %b %d %H:%M:%S %Y')
        end
        xml.body do
          blk.call(xml) if blk
        end
      end
    end
  end
end

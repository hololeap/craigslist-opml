class GeneratorController < ApplicationController
  before_filter :check_params, only: :create

  def index
    @regions = Region.roots
    @categories = Category.roots
  end

  def create
    cities, categories = [], []

    [Region, Subregion].each do |klass|
      @items[klass].each_key {|item| cities |= item.cities} if @items[klass]
    end

    [City, Subcity].each do |klass| 
      cities |= @items[klass].keys if @items[klass]
    end

    if @items[Category]
      @items[Category].each do |item, hash|
        item.add_search hash['search']
        categories << item
      end
    end

    send_data Craigslist::OPML.create(cities, categories).to_xml, 
              filename: 'craigslist.opml',
              type: 'application/xml'

  end

  def get_list
    @partial = params[:partial]
    klass = params[:class] && params[:class].constantize rescue nil
    render status: 404 unless klass and @item = klass.find(params[:id])
    @dropdown_id = "#{klass.name.downcase}_#{@item.id}_dropdown"
    respond_to do |format|
      format.js
    end
  end

  def get_search
    render status: 404 unless @item = Category.find(params[:id])
    @box_id = "search_#{@item.id}_box"
    respond_to do |format|
      format.js
    end
  end

  private

  def check_params
    @items = {}
    valid_names = %w{region subregion city subcity category}
    params.each do |name, val|
      if valid_names.include? name
        klass = name.camelize.constantize
        val.each do |id, hash|
          hash = hash.dup
          @items[klass] ||= {} 
          render status: 404 unless item = klass.find(id)
          @items[klass][item] = hash if hash.delete('chosen') == 'true'
        end
      end
    end
  end
end

class Post < ActiveRecord::Base
  class << self
    private
    def title_attribute(name, method = nil)
      define_method name do
        m = category.match(title, name.to_s)
        method ? m.send(method) : m
      end
    end
  end

  belongs_to :feed
  has_one :category, through: :feed

  title_attribute :price, :to_f
  title_attribute :location

  def title_body
    title + body
  end
end

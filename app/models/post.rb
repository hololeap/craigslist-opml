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

  def contains?(string, case_sensitive = false)
    [title, body].any? do |x|
      if case_sensitive
        x.include? string
      else
        x.downcase.include? string.downcase
      end
    end
  end
end

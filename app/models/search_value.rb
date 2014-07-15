class SearchValue < ActiveRecord::Base
  belongs_to :search_field
  belongs_to :feed

  def value
  end
end

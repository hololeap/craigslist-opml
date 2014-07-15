class SearchField < ActiveRecord::Base
  belongs_to :category
  belongs_to :field, polymorphic: true
end

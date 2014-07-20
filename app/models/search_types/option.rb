class SearchTypes::Option < ActiveRecord::Base
  belongs_to :search_select

  def self.convert_string(s)
    s == 'true'
  end
end

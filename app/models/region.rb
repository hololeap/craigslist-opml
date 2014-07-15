class Region < ActiveRecord::Base
  has_many :subregions, class_name: 'Subregion'
  has_many :cities, through: :subregions
  has_many :subcities, through: :cities

  alias :children :subregions
  
  def has_children?
    subregions.count > 0
  end
  
  def self.roots
    where(type: nil).order(:id)
  end
end

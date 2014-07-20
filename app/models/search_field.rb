class SearchField < ActiveRecord::Base
  has_and_belongs_to_many :categories
  belongs_to :field, polymorphic: true
  has_many :search_values

  def self.create_with_type(type, type_opts, opts = {})
    klass = ('SearchTypes::' + type.to_s.camelize).constantize
    self.create! opts.merge(field: klass.find_or_create_by!(type_opts))
  end

  def field_class
    field_type.constantize
  end

end

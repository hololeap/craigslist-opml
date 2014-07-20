class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name
      t.string :url
      t.string :abbrev
      t.belongs_to :region
      t.belongs_to :city

      t.string :type

      t.timestamps
    end
  end
end

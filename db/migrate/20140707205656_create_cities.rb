class CreateCities < ActiveRecord::Migration
  def change
    create_table :cities do |t|
      t.string :name, null: false, default: ''
      t.string :url, null: false, default: ''
      t.belongs_to :region, index: true
      t.belongs_to :city, index: true

      t.string :type

      t.timestamps
    end
  end
end

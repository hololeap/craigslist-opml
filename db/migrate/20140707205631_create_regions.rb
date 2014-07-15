class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name, null: false, default: ''
      t.belongs_to :region, index: true
      
      t.string :type

      t.timestamps
    end
  end
end

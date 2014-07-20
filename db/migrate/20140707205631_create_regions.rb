class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.string :name
      t.belongs_to :region
      
      t.string :type

      t.timestamps
    end
  end
end

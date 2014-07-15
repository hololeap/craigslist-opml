class CreateSearchBooleans < ActiveRecord::Migration
  def change
    create_table :search_booleans do |t|
      t.string :name

      t.timestamps
    end
  end
end

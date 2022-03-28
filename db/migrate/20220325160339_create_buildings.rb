class CreateBuildings < ActiveRecord::Migration[6.1]
  def change
    create_table :buildings do |t|
      t.string :address
      t.float :lat
      t.float :lng
      t.float :ne_lat
      t.float :ne_long
      t.float :sw_lat
      t.float :sw_lng
      t.float :surface
      t.string :nom

      t.timestamps
    end
  end
end

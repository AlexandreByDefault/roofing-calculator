class ChangeLongToLngOnBuildings < ActiveRecord::Migration[6.1]
  def change
    rename_column :buildings, :ne_long, :ne_lng
  end
end

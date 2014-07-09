class AddLongitudeAndLatitudeToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :longitude, :float
    add_column :profiles, :latitude, :float
  end
end

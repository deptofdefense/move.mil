class RemoveLocationFromInstallations < ActiveRecord::Migration[5.1]
  def change
    remove_column :installations, :street_address
    remove_column :installations, :extended_address
    remove_column :installations, :locality
    remove_column :installations, :region
    remove_column :installations, :region_code
    remove_column :installations, :postal_code
    remove_column :installations, :country_name
    remove_column :installations, :country_code
    remove_column :installations, :latitude
    remove_column :installations, :longitude
  end
end

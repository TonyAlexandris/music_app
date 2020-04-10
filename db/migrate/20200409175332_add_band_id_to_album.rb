class AddBandIdToAlbum < ActiveRecord::Migration[6.0]
  def change
    add_column :albums, :band_id, :integer, null: false
    add_index :albums, :band_id
  end
end

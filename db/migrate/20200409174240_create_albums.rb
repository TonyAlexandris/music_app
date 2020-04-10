class CreateAlbums < ActiveRecord::Migration[6.0]
  def change
    create_table :albums do |t|
      t.timestamps
      t.string :title, null: false
      t.integer :year, null: false
      t.boolean :studio_album, null: false, default: true
    end
    add_index :albums, :year
  end
end
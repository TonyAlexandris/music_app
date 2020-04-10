class CreateTracks < ActiveRecord::Migration[6.0]
  def change
    create_table :tracks do |t|
      t.timestamps
      t.integer :album_id, null: false
      t.string :title, null: false
      t.integer :ord, null: false
      t.boolean :bonus_track, null: false
      t.text :lyrics
    end
    add_index :tracks, :album_id
  end
end
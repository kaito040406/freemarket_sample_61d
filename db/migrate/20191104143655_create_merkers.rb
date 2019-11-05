class CreateMerkers < ActiveRecord::Migration[5.2]
  def change
    create_table :merkers do |t|
      t.string  :name
      t.string  :genre
      t.integer :genre_number
      t.timestamps
    end
  end
end

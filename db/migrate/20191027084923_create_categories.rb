class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string   :name, null: false
      t.integer  :parent_id, null: true, foreign_key: false
      t.timestamps
    end
  end
end

class CreateSnscredentials < ActiveRecord::Migration[5.2]
  def change
    create_table :snscredentials do |t|
      t.string  :provider
      t.text    :uid
      t.integer :mid
      t.text    :token
      t.text    :pass_token
      t.text    :email
      t.timestamps
    end
  end
end

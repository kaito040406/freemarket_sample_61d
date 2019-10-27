class AddColumnsToUser < ActiveRecord::Migration[5.2]
  def change
    #add_column :users,  :piyo,            :string
    add_column :users,  :nick_name,       :string,  null: false 
    add_column :users,  :sur_name,        :string,  null: false 
    add_column :users,  :first_name,      :string,  null: false 
    add_column :users,  :sur_name_yomi,   :string,  null: false 
    add_column :users,  :first_name_yomi, :string,  null: false 
    add_column :users,  :introduction,    :string,  null: true 
    add_column :users,  :birthday,        :date,    null: false 
    #add_column :users,  :email,           :string,  null: false 
    #add_column :users,  :password,        :string,  null: false 
    add_column :users,  :tel_number,      :string,  null: false 
    add_column :users,  :account,         :integer, null:false 
    add_column :users,  :sales_money,     :integer, null: false 
    add_column :users,  :point,           :integer, null: false 
    add_column :users,  :icon_image,      :string , null: true 
  end
end

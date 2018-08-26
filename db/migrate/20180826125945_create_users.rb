class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :facebook_id
      t.text :profile_pic_url

      t.timestamps
    end
  end
end

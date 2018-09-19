class CreateFacebookMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :facebook_messages do |t|
      t.text :name
      t.integer :category
      t.text :body
      t.jsonb :quick_replies
      t.jsonb :buttons

      t.timestamps
    end
  end
end

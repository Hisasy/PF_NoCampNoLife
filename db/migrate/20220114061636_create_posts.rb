class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :main_title
      t.date :date
      t.string :location
      t.string :sub_title
      t.text :body
      t.json :images

      t.timestamps
    end
  end
end

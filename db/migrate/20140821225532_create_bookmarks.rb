class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.text :url
      t.text :title
      t.string :tag_list
      t.integer :user_id

      t.timestamps
    end
  end
end

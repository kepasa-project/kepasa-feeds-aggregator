class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.integer :page_id
      t.integer :newspaper_id

      t.timestamps
    end
  end
end

class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :rssurl
      t.string :guid
      t.string :name
      t.datetime :published_at
      t.text :summary
      t.string :url
      t.string :image
      t.integer :user_id

      t.timestamps
    end
  end
end

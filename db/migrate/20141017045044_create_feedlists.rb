class CreateFeedlists < ActiveRecord::Migration[5.1]
  def change
    create_table :feedlists do |t|
      t.string :rssurl
      t.string :guid
      t.string :name
      t.datetime :published_at
      t.text :summary
      t.string :url
      t.string :image
      t.integer :feed_id

      t.timestamps
    end
  end
end

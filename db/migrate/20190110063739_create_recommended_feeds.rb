class CreateRecommendedFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :recommended_feeds do |t|
      t.string :rssurl
      t.string :title
      t.integer :category_id

      t.timestamps
    end
  end
end

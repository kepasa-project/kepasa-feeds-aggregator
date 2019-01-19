class CreateJoinTableCategoryRecommendedFeed < ActiveRecord::Migration[5.1]
  def change
    create_join_table :categories, :recommended_feeds do |t|
      #t.index [:category_id, :recommended_feed_id]
      #t.index [:recommended_feed_id, :category_id]
    end
  end
end

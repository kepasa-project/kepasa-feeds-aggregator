class RemoveCategoryIdFromRecommendedFeeds < ActiveRecord::Migration[5.1]
  def change
    remove_column :recommended_feeds, :category_id, :integer
  end
end

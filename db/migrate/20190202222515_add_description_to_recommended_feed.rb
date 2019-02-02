class AddDescriptionToRecommendedFeed < ActiveRecord::Migration[5.1]
  def change
    add_column :recommended_feeds, :description, :string
  end
end

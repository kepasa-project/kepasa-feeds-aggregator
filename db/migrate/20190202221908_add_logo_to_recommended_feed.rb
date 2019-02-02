class AddLogoToRecommendedFeed < ActiveRecord::Migration[5.1]
  def change
    add_column :recommended_feeds, :logo, :string
  end
end

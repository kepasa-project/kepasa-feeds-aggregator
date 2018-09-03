class RemoveGuidAndNameAndPublishedAtAndSummaryAndUrlAndImageFromFeeds < ActiveRecord::Migration[5.1]
  def up
    remove_column :feeds, :guid
    remove_column :feeds, :name
    remove_column :feeds, :published_at
    remove_column :feeds, :summary
    remove_column :feeds, :url
    remove_column :feeds, :image
  end

  def down
    add_column :feeds, :image, :string
    add_column :feeds, :url, :string
    add_column :feeds, :summary, :text
    add_column :feeds, :published_at, :datetime
    add_column :feeds, :name, :string
    add_column :feeds, :guid, :string
  end
end

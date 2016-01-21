class AddImageToFeedEntries < ActiveRecord::Migration
  def change
    add_column :feed_entries, :image, :string
  end
end

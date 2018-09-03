class AddImageToFeedEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :feed_entries, :image, :string
  end
end

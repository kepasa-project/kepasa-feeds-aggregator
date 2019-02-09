class AddFaviconToFeeds < ActiveRecord::Migration[5.1]
  def change
    add_column :feeds, :favicon, :string
  end
end

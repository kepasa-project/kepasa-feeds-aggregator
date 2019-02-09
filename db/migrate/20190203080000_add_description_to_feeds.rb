class AddDescriptionToFeeds < ActiveRecord::Migration[5.1]
  def change
    add_column :feeds, :description, :string
  end
end

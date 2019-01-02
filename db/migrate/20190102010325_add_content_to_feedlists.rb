class AddContentToFeedlists < ActiveRecord::Migration[5.1]
  def change
    add_column :feedlists, :content, :text
  end
end

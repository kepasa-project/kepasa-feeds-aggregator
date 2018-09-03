class RemoveGuidAndNameAndPublishedAtAndSummaryAndUrlAndImageFromNewspapers < ActiveRecord::Migration[5.1]
  def up
    remove_column :newspapers, :guid
    remove_column :newspapers, :name
    remove_column :newspapers, :published_at
    remove_column :newspapers, :summary
    remove_column :newspapers, :url
    remove_column :newspapers, :image
  end

  def down
    add_column :newspapers, :image, :string
    add_column :newspapers, :url, :string
    add_column :newspapers, :summary, :text
    add_column :newspapers, :published_at, :datetime
    add_column :newspapers, :name, :string
    add_column :newspapers, :guid, :string
  end
end

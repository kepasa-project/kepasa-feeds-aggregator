class CreateNewspapers < ActiveRecord::Migration
  def change
    create_table :newspapers do |t|
      t.string :rssurl
      t.string :guid
      t.string :name
      t.datetime :published_at
      t.text :summary
      t.string :url
      t.string :image

      t.timestamps
    end
  end
end

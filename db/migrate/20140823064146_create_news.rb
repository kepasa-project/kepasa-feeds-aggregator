class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :guid
      t.string :name
      t.datetime :published_at
      t.text :summary
      t.string :url
      t.string :image
      t.integer :newspaper_id

      t.timestamps
    end
  end
end

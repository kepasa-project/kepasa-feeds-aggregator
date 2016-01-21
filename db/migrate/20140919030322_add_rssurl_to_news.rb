class AddRssurlToNews < ActiveRecord::Migration
  def change
    add_column :news, :rssurl, :string
  end
end

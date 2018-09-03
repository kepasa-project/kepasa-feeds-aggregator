class AddRssurlToNews < ActiveRecord::Migration[5.1]
  def change
    add_column :news, :rssurl, :string
  end
end

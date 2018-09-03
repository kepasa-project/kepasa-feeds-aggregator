class ChangeDataTypeForUrlColumnInFeedlistsTable < ActiveRecord::Migration[5.1]
  def self.up
    change_table :feedlists do |t|
      t.change :url, :text
    end
  end
  def self.down
    change_table :feedlists do |t|
      t.change :url, :string
    end
  end
end

class ChangeDataTypeForNameColumnInFeedlistsTable < ActiveRecord::Migration[5.1]
  def self.up
    change_table :feedlists do |t|
      t.change :name, :text
    end
  end
  def self.down
    change_table :feedlists do |t|
      t.change :name, :string
    end
  end
end

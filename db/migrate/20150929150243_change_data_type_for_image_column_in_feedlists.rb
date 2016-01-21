class ChangeDataTypeForImageColumnInFeedlists < ActiveRecord::Migration
  def self.up
    change_table :feedlists do |t|
      t.change :image, :text
    end
  end
  def self.down
    change_table :feedlists do |t|
      t.change :image, :string
    end
  end
end

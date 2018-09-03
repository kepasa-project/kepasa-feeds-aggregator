class ChangeDataTypeForImageColumnInFeedlists < ActiveRecord::Migration[5.1]
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

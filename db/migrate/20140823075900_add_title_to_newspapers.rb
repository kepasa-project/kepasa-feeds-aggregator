class AddTitleToNewspapers < ActiveRecord::Migration
  def change
    add_column :newspapers, :title, :string
  end
end

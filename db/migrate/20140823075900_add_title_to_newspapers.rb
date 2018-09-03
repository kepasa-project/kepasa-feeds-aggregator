class AddTitleToNewspapers < ActiveRecord::Migration[5.1]
  def change
    add_column :newspapers, :title, :string
  end
end

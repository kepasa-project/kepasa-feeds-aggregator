class AddPageIdToNewspapers < ActiveRecord::Migration[5.1]
  def change
    add_column :newspapers, :page_id, :integer
  end
end

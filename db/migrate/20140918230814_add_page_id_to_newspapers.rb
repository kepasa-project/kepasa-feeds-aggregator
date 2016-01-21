class AddPageIdToNewspapers < ActiveRecord::Migration
  def change
    add_column :newspapers, :page_id, :integer
  end
end

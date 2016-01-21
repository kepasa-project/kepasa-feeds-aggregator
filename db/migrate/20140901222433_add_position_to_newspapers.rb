class AddPositionToNewspapers < ActiveRecord::Migration
  def change
    add_column :newspapers, :position, :integer
  end
end

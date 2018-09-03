class AddPositionToNewspapers < ActiveRecord::Migration[5.1]
  def change
    add_column :newspapers, :position, :integer
  end
end

class AddKeysForDeleteFeedlists < ActiveRecord::Migration[5.2]
  def change
  	add_foreign_key :feedlists, :feeds, on_delete: :cascade 
  end
end

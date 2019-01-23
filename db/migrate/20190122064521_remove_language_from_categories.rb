class RemoveLanguageFromCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :language, :string
  end
end

class AddLanguageToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :language, :integer, default: 0
  end
end

class AddTitleToPages < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :title, :string
  end
end

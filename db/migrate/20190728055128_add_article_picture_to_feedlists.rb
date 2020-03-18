class AddArticlePictureToFeedlists < ActiveRecord::Migration[5.2]
  def change
    add_column :feedlists, :article_picture, :string
  end
end

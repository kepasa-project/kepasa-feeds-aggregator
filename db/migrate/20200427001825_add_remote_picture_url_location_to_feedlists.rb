class AddRemotePictureUrlLocationToFeedlists < ActiveRecord::Migration[5.2]
  def change
    add_column :feedlists, :remote_picture_url_location, :text
  end
end

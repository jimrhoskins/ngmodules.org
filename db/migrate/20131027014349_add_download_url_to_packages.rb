class AddDownloadUrlToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :download_url, :string
  end
end

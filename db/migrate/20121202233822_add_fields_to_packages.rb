class AddFieldsToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :homepage, :string
    add_column :packages, :description, :string
    add_column :packages, :readme_markdown, :text
  end
end

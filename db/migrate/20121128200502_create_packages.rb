class CreatePackages < ActiveRecord::Migration
  def change
    create_table :packages do |t|
      t.string :name
      t.string :github_repo

      t.timestamps
    end
  end
end

class AddUsersToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :owner_id, :integer
    add_column :packages, :submitter_id, :integer
  end
end

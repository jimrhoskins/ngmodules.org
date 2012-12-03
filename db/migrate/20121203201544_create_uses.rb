class CreateUses < ActiveRecord::Migration
  def change
    create_table :uses do |t|
      t.integer :user_id
      t.integer :package_id

      t.timestamps
    end
  end
end

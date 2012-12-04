class AddCounterCacheToPackages < ActiveRecord::Migration
  def change
    add_column :packages, :uses_count, :integer, default: 0
    Package.reset_column_information
    Package.find(:all).each do |p|
      Package.update_counters p.id, :uses_count => p.uses.count
    end
  end
end

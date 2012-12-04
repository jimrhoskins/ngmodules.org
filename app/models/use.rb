class Use < ActiveRecord::Base
  belongs_to :user
  belongs_to :package, counter_cache: true
  validates_uniqueness_of :package_id, scope: :user_id
  validates_presence_of :package_id, :user_id
end

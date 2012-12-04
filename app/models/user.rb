class User < ActiveRecord::Base

  has_many :submitted_packages, class_name: "Package", foreign_key: :submitter_id
  has_many :owned_packages, class_name: "Package", foreign_key: :owner_id

  has_many :uses
  has_many :used_packages, through: :uses, source: :package

  def self.find_or_create_by_oauth(oauth) 
    user = find_by_provider_and_uid(oauth["provider"], oauth["uid"])
    if user
      user.update_from_oauth(oauth)
      user.save!
      user
    else
      create_by_oauth(oauth)
    end
  end

  def self.create_by_oauth(oauth)
    create do |user|
      user.provider = oauth["provider"]
      user.uid = oauth["uid"]

      user.update_from_oauth oauth
    end
  end

  def update_from_oauth(oauth)
    self.nickname = oauth["info"]["nickname"]
    self.name = oauth["info"]["name"]
    self.email = oauth["info"]["email"]
    self.avatar_url = oauth["info"]["image"]
  end

  def self.find_or_create_by_github(username)
    find_by_nickname(username) or create_by_github(username)
  end

  def self.create_by_github(username) 
    api = Github.users.get user: username 
    create do |user|
      user.provider = "github"
      user.uid = api.id


      user.nickname = api.login
      user.name = api.name
      user.email = api.email
      user.avatar_url = api.avatar_url
    end
  rescue Github::Error::NotFound
    nil
  end

  def profile_url
    "https://github.com/#{nickname}"
  end

  def does_use(package)
    uses.find_or_create_by_package_id! package.id
  end

  def does_not_use(package)
    uses.where(package_id: package.id).destroy_all
  end


end

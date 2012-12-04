require 'factory_girl'

FactoryGirl.define do
  factory :package do
    github_repo "octocat/ngmod"
    name "ngMod"
    description "An awesome module"
  end

  factory :user do
    provider 'github'
    sequence :uid do |n| n.to_s end
    sequence :email do |n| "user#{n}@example.com" end
    name "Octocat Black"
    sequence :nickname do |n| "user#{n}" end
    admin false
    avatar_url "http://gravatar.com/abcdeg"
  end
end

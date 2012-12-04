require 'minitest_helper'

describe User do

  it 'has many owned and submitted projects' do
    angulars = create :user, nickname: 'angulars'
    octocat = create :user, nickname: 'octocat'

    pkg = angulars.submitted_packages.create attributes_for(:package, github_repo: "octocat/foo")

    angulars.reload
    angulars.submitted_packages.must_equal [pkg]
    angulars.owned_packages.must_be_empty

    octocat.reload
    octocat.owned_packages.must_equal [pkg]
    octocat.submitted_packages.must_be_empty
  end

  it 'has many used packages' do
    octocat = create :user, nickname: 'octocat'
    mod1 = create :package, github_repo: "octocat/mod1"
    mod2 = create :package, github_repo: "octocat/mod2"

    octocat.used_packages.must_be_empty

    octocat.does_use mod1
    octocat.does_use mod2

    octocat.reload
    octocat.used_packages.must_include mod1
    octocat.used_packages.must_include mod2

    octocat.does_not_use mod1

    octocat.reload
    octocat.used_packages.wont_include mod1
    octocat.used_packages.must_include mod2

  end

end

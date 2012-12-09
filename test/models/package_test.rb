require 'minitest_helper'

describe Package do
  before do
    User.delete_all
    Package.delete_all
    HTTPMocks::stub_octocat
  end
  it 'should require appropriate fields' do
    package = Package.new
    package.save.must_equal false

    package.errors[:github_repo].wont_be_empty
    package.errors[:name].wont_be_empty
    package.errors[:description].wont_be_empty

  end
  
  it 'accepts valid github_repos' do
    build(:package, github_repo: "foo/bar1").valid?.must_equal true
    build(:package, github_repo: "foo/BAR2").valid?.must_equal true

  end

  it 'enforces uniqueness of name' do
    octocat = create :user
    create :package, name: "specialname", submitter: octocat
    dup = build :package, name: "specialname", submitter: octocat

    dup.save.must_equal false
    dup.errors[:name].wont_be_empty

    dup = build :package, name: "sPecIalNAMe", submitter: octocat

    dup.save.must_equal false
    dup.errors[:name].wont_be_empty
  end

  it 'should be taggable' do
    package = create :package
    package.tag_list = "foo, bar"
    package.save.must_equal true
    package.tags.count.must_equal 2
  end

  it 'should have an owner and submitter' do
    user1 = create :user
    user2= create :user

    package = create :package

    package.owner = user1
    package.submitter = user2

    package.owner_id.must_equal user1.id
    package.submitter_id.must_equal user2.id
  end

  it 'should assign the owner on save based on repo' do
    octocat = create :user, nickname: 'octocat'
    angulars = create :user, nickname: 'angulars'
    package = build :package, github_repo: "octocat/mod", submitter: angulars

    package.save.must_equal true
    package.owner.must_equal octocat
    package.submitter.must_equal angulars
  end

  it 'should provide a list of users' do
    octocat = create :user, nickname: 'octocat'
    angulars = create :user, nickname: 'angulars'

    package = create :package, github_repo: "octocat/mod", submitter: octocat

    angulars.does_use package

    package.reload
    package.users.must_equal [angulars]
    package.uses_count.must_equal 1

    angulars.does_not_use package

    package.reload
    package.uses_count.must_equal 0
    package.users.must_be_empty
  end

  it 'should be claimed only if owner is submitter' do
    octocat = create :user, nickname: 'octocat'
    angulars = create :user, nickname: 'angulars'

    package = create :package, github_repo: "octocat/mod", submitter: angulars

    package.claimed.must_equal false

    package.submitter = octocat

    package.claimed.must_equal true
  end

  it 'provides the github user' do 
    package = build :package, github_repo: "octoCat/mod"
    package.github_user.must_equal "octocat"
  end

  it 'provides the github URL' do 
    package = build :package, github_repo: "octoCat/mod"
    package.github_url.must_equal "https://github.com/octoCat/mod"
  end

  it 'provides the download URL' do 
    package = build :package, github_repo: "octoCat/mod"
    package.download_url.must_equal "https://github.com/octoCat/mod/archive/master.zip"
  end

  it 'renders readme html' do 
    package = build :package, readme_markdown: <<README
# Title

* one
* two

`code` is here
README

    package.readme_html.must_equal <<-HTML
<h1>Title</h1>

<ul>
<li>one</li>
<li>two</li>
</ul>

<p><code>code</code> is here</p>
HTML


  end


end

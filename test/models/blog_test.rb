require 'minitest_helper' 

describe BlogPost do

  it 'requires title, permalink, user, and content' do
    post = BlogPost.new
    post.save.must_equal false
    post.errors[:title].wont_be_empty
    post.errors[:permalink].wont_be_empty
    post.errors[:user_id].wont_be_empty
    post.errors[:content_markdown].wont_be_empty
  end

  it 'has a url compatible permalink' do
    post = BlogPost.new permalink: "simple-permalink"
    post.permalink.must_equal "simple-permalink"

    post = BlogPost.new permalink: "with spaces"
    post.permalink.must_equal "with-spaces"

    post = BlogPost.new permalink: "CapS and stuff"
    post.permalink.must_equal "caps-and-stuff"

    post = BlogPost.new permalink: "Jim's favorite 1 thing?"
    post.permalink.must_equal "jims-favorite-1-thing"
  end

  it 'should use the permalink as param' do
    post = BlogPost.new permalink: "Foo"
    post.to_param.must_equal 'foo'

  end


  it 'has an author ' do
    user = create :user
    post = BlogPost.new user: user

    post.user.must_equal user
  end

  it 'renders markdown' do
    blog = BlogPost.new content_markdown: "# Hello"
    blog.content_html.must_equal "<h1>Hello</h1>\n"
  end
end

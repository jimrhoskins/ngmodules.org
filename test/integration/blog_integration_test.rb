require 'minitest_helper'

describe 'Blog integration' do

  it 'creates a new blog post' do
    login_with_oauth
    User.find_by_nickname("octocat").update_attribute :admin, true
    visit new_blog_post_path

    form = page.find('form#new_blog_post')
    form.fill_in "Title", with: "My awesome title"
    form.fill_in "Permalink", with: "awesome-title"
    form.fill_in "Content", with: "# Title
    other stuff
    "

    click_button "Save Draft"

    blog = BlogPost.find_by_permalink "awesome-title"
    blog.published.wont_equal true
  end

  it 'publishes a new blog post' do
    login_with_oauth
    User.find_by_nickname("octocat").update_attribute :admin, true
    visit new_blog_post_path

    form = page.find('form#new_blog_post')
    form.fill_in "Title", with: "My awesome title"
    form.fill_in "Permalink", with: "awesome-title"
    form.fill_in "Content", with: "# Title
    other stuff
    "

    click_button "Publish Now"

    blog = BlogPost.find_by_permalink "awesome-title"
    blog.published.must_equal true
  end

  it 'shows only published articles on the home page' do
    author = create :user
    top_post = BlogPost.create(
      title: "Published Post the First",
      permalink: "pub1",
      content_markdown: "Hello",
      published: true,
      user: author,
      published_at: 10.minutes.ago
    )

    older_post = BlogPost.create(
      title: "Published Post the Older",
      permalink: "older",
      content_markdown: "Hello",
      published: true,
      user: author,
      published_at: 20.minutes.ago
    )

    future_post = BlogPost.create(
      title: "Future Post",
      permalink: "future-post",
      content_markdown: "In the future",
      published: true,
      user: author,
      published_at: 10.minutes.from_now
    )

    hidden_post = BlogPost.create(
      title: "Hidden Post",
      permalink: "hidden-post",
      content_markdown: "I'm gone",
      published: false,
      user: author,
      published_at: 10.minutes.ago
    )

    visit blog_posts_path

    page.text.must_include "Published Post the Older"
    page.text.must_include "Published Post the First"

    page.text.wont_include "Future Post"
    page.text.wont_include "Hidden Post"

  end
end

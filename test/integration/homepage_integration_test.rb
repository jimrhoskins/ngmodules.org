require 'minitest_helper'

describe 'Homepage integration' do
  before do
    HTTPMocks::stub_octocat
  end

  it 'lists recent modules' do
    create :package, name: "AwesomeModule", tag_list: "tag1, tag2"
    visit root_path
    page.text.must_include "AwesomeModule"
    page.text.must_include "tag1"
    page.text.must_include "tag2"
  end

end



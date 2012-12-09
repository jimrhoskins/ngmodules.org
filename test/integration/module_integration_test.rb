require 'minitest_helper'

describe 'module integration' do
  before do
    HTTPMocks::stub_octocat
  end

  it 'finds by name' do
    create :package, name: "simplemodule", submitter: create(:user)
    create :package, name: "dotted.module_name", submitter: create(:user)

    visit "/modules/simplemodule"

    page.text.must_include "Homepage"
    page.text.must_include "simplemodule"

    visit "/modules/dotted.module_name"
    page.text.must_include "Homepage"
    page.text.must_include "dotted.module_name"


  end

  it 'paginates by 15' do 
    20.times { create :package }
    visit "/"


    page.all(".package").count.must_equal 15

    page.find('.pagination').click_link "2"

    page.all(".package").count.must_equal 5

  end

end

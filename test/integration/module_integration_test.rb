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

end

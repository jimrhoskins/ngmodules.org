require 'minitest_helper'

describe 'Add module integration' do

  it 'shows the form from when logged in' do
    # Login and visit homepage
    login_with_oauth
    visit root_path

    # Ensure we are logged in as octocat
    page.text.must_include "octocat" 

    # Navigate to New Module Form
    click_link "Add a Module"


    # Fill out form
    fill_in 'Github URL', with: "octocat/awesome.module"
    fill_in 'Name', with: "AwesomeMod"
    fill_in 'Description', with: 'Awesome.Description'
    fill_in 'Homepage', with: 'http://example.com/mod'
    fill_in 'Tags', with: 'Tag1, Tag2'
    fill_in 'README', with: '#ReadmeHeader'

    #Submit
    click_button 'Create Package'

    # Check for various properties
    page.text.must_include "AwesomeMod"
    page.text.must_include "http://example.com/mod"
    page.text.must_include "Tag1"
    page.text.must_include "Tag2"
    page.text.wont_include 'Github URL'
    page.text.must_include 'ReadmeHeader'

    # Make sure readme is rendering HTML
    page.find('.readme h1').text.must_include 'ReadmeHeader'

    # Show Edit/Destroy links, since we are the submitter
    find_link('Edit').visible?.must_equal true
    find_link('Remove').visible?.must_equal true
  end

  it "doesn't show the form when logged out" do
    visit root_path
    click_link "Add a Module"

    page.text.must_include "Please sign in to add a new module"
  end
end

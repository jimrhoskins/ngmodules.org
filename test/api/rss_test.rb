require 'minitest_helper'

describe 'Atom feed integration' do

  it 'has a link on home page' do
    visit '/'
    link = page.find('link[rel="alternate"][type="application/atom+xml"]')
    link['href'].must_equal "/modules.atom"
    link['title'].must_equal "Latest AngularJS Modules"
  end

  describe 'atom feed' do
    before do @mod3 = create :package, created_at: 9.minutes.ago
      # Add a use count to differentiate it from (popular,newest) default count
      @mod3.owner.does_use @mod3 
      @mod1 = create :package, created_at: Time.now
      @mod2 = create :package, created_at: 2.minutes.ago
      visit "/modules.atom"
      @doc = Hash.from_xml(page.body)
    end 




    it 'has a feed and language' do
      @doc["feed"]["xml:lang"].must_equal "en-US"
    end

    it 'is titled correctly' do
      @doc["feed"]["title"].must_equal "Latest AngularJS Modules"
    end

    it 'has some modules' do
      @doc["feed"]["entry"].size.must_equal 3
    end

    it 'orders based on created at' do
      @doc["feed"]["entry"][0]["title"].must_equal @mod1.name
      @doc["feed"]["entry"][1]["title"].must_equal @mod2.name
      @doc["feed"]["entry"][2]["title"].must_equal @mod3.name
    end

    it 'provides accurate information for an entry' do
      entry = @doc["feed"]["entry"][0]

      entry['title'].must_equal @mod1.name
      entry['url'].must_equal package_url(@mod1.name, host: 'ngmodules.org')
      entry['summary'].must_equal @mod1.description
      entry['updated'].must_equal @mod1.updated_at.strftime("%Y-%m-%dT%H:%M:%SZ")

    end
  end
end

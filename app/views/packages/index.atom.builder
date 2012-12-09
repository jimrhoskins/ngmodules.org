atom_feed language: 'en-US' do |feed|
  feed.title "Latest AngularJS Modules"
  @packages.each do |package|
    feed.entry package do |entry|
      entry.url  package_url(package)
      entry.title package.name
      entry.summary package.description

      entry.author do |author|
        author.name package.owner.name
        author.uri package.owner.profile_url
      end
    end

  end
end

# Ngmodules.org Web Site 

The primary focus of ngmodules.org is to provide the ability to share
and discover Angular.js modules.

## Contributing

Contributions are welcome and appreciated. Pull requests are the
requested mode of contribution. If you are planning on implementing new
functionality, please bring it up on the Github issues page, to prevent
duplicated effort.

## Installing

This is a ruby on rails application. It has only a few requirements:

  * Ruby 1.9.3
  * PostgreSQL (Fulltext search powered by pg)
  * pygments (for syntax highlighting)
  * Rubygems
  * Bundler

Clone the repo

    git clone git://github.com/jimrhoskins/ngmodules.org.git
    cd ngmodules.org

Install dependencies

    bundle

Edit Database details

    cp config/database.yaml.example config/database.yaml
    # Edit config/database.yaml

Create and load the database

    bundle exec rake db:create:all
    bundle exec rake db:schema:load 

Create a Github App to obtain a key and secret. Set the callback URL to
`http://localhost:3000/auth/github/callback` (Replace localhost:3000
with your local host:port)

    export GITHUB_KEY="YOUR_KEY_HERE"
    export GITHUB_SECRET="YOUR_SECRET_HERE"

Run the server

    bundle exec rails server

Open http://localhost:3000
    
Once you have authenticated, you may wish to set your user as an admin.
Load the rails console by running `rails console`

When loaded, run the following code, with your Github username in place
of LOGIN
    > User.find_by_nickname("LOGIN").update_attribute :admin, true
    > exit


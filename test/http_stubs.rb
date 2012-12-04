
module HTTPMocks
  extend WebMock::API

  def self.stub_octocat
    stub_request(:get, 
      "https://api.github.com/users/octocat"
    ).to_return(
      body: <<-JSON
        {
          "type": "User",
          "avatar_url": "https://secure.gravatar.com/avatar/7ad39074b0584bc555d0417ae3e7d974?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png",
          "created_at": "2011-01-25T18:44:36Z",
          "html_url": "https://github.com/octocat",
          "repos_url": "https://api.github.com/users/octocat/repos",
          "hireable": false,
          "email": "octocat@github.com",
          "received_events_url": "https://api.github.com/users/octocat/received_events",
          "public_gists": 4,
          "bio": null,
          "events_url": "https://api.github.com/users/octocat/events{/privacy}",
          "organizations_url": "https://api.github.com/users/octocat/orgs",
          "followers_url": "https://api.github.com/users/octocat/followers",
          "url": "https://api.github.com/users/octocat",
          "gravatar_id": "7ad39074b0584bc555d0417ae3e7d974",
          "blog": "http://www.github.com/blog",
          "location": "San Francisco",
          "gists_url": "https://api.github.com/users/octocat/gists{/gist_id}",
          "following_url": "https://api.github.com/users/octocat/following",
          "name": "The Octocat",
          "company": "GitHub",
          "starred_url": "https://api.github.com/users/octocat/starred{/owner}{/repo}",
          "login": "octocat",
          "followers": 264,
          "subscriptions_url": "https://api.github.com/users/octocat/subscriptions",
          "id": 583231,
          "public_repos": 3,
          "following": 0
        }
      JSON
    )
  end

end


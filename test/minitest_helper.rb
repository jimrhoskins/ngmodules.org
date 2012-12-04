ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "minitest/autorun"
require "capybara/rails"
require "active_support/testing/setup_and_teardown"
require 'factories'
require 'webmock/minitest'
require 'http_stubs'


class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
end

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  register_spec_type(/integration$/, self)


  def login_with_oauth
    visit "/auth/github"
  end
end

Capybara.default_host = "http://ngmodules.org"

class HelperTest < MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  include ActionView::TestCase::Behavior
  register_spec_type(/Helper$/, self)
end

Turn.config.format = :outline

OmniAuth.config.test_mode = true
OmniAuth.config.add_mock(:github, {
  uid:  '12345',
  nickname: 'octocat',

  info: {
    nickname: 'octocat',
    name: 'Octocat McGithub',
    email: 'octocat@github.com'
  }

})

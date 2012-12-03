class CanonicalRedirect
  def initialize(app)
    @app = app
  end

  def call(env)
    request = Rack::Request.new(env)

    #return [200, {}, [ENV['CANONICAL_HOST'], request.host]]
    if ENV['CANONICAL_HOST'] && request.host.downcase != ENV['CANONICAL_HOST']
      [301, {"Location" => request.url.sub("//#{request.host}", "//#{ENV['CANONICAL_HOST']}") }, self]
    else
      @app.call(env)
    end
  end

  def each(&block)
  end
end

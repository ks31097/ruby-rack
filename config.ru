# $ curl http://localhost:9292

class Application
  def call(env)
    [200, { "content-type" => "text/html" }, ['Hello world!']]
  end
end

run Application.new

# $ curl -iv http://localhost:9292

class Application
  def call(env)
    status = 200
    headers =  { "content-type" => "text/html" }
    body = ['Hello world!']

    [status, headers, body]
  end
end

run Application.new

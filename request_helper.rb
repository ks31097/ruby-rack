# frozen_string_literal: true

module RequestHelper
  def handle_request(method, path)
    if method == 'GET'
      get(path)
    else
      method_not_allowed(method)
    end
  end

  def get(path)
    response = Rack::Response.new
    response.status = 200
    # write some content to the body
    response.body = ["You have requested the path #{path}, using GET"]
    # or set it directly
    # response.write "You have requested the path #{path}, using GET"
    response['Content-Type'] = 'text/html'
    response.finish
  end

  def method_not_allowed(method)
    [405, { 'content-type' => 'text/html' }, ["Method not allowed: #{method}"]]
  end
end

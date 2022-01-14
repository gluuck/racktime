require_relative 'time_format'
require 'rack'

class App
  attr_accessor :request

  def call(env)
    @request = Rack::Request.new(env)
    params = if request.path_info == '/time'
               time_response
             else
               [["Page not found."], 404, headers]
             end
    Rack::Response.new(*params).finish
  end
  
  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def time_response
    time = TimeFormat.new(request.params)
    body =  time.get_time
    if time.success?      
      [body, 200, headers]
    else
      [body, 400, headers]
    end
  end
end

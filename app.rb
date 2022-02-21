require_relative 'time_format'
require 'rack'

class App
  attr_accessor :request

  def call(env)
    @request = Rack::Request.new(env)
    params = time_response
             
    Rack::Response.new(*params).finish
  end
  
  private

  def time_response
    time = TimeFormat.new(request.params)
    body =  time.get_time
    if time.success?      
      [body, 200]
    else
      [body, 400]
    end
  end
  
end

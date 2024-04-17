# /app.rb

require "sinatra"
require "sinatra/reloader"
require "http"

@EXCHANGE_RATE_KEY = ENV["EXCHANGE_RATE_API"]

# define a route
get("/") do
  
  erb(:test)
  
end

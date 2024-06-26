# /app.rb

require "sinatra"
require "sinatra/reloader"
require "http"
require "json"


@EXCHANGE_RATE_KEY = ENV["EXCHANGE_RATE_API"]

# define a route
get("/") do
  
  # build the API url, including the API key in the query string
  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_API"]}"

  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)
 
  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  # get the symbols from the JSON
  currency_hash = parsed_data.fetch("currencies")
  @symbols = currency_hash.keys()

  # render a view template where I show the symbols
  erb(:homepage)

end

get("/:from_currency") do
  @original_currency = params.fetch("from_currency")

  api_url = "https://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATE_API"]}"
  
  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)
 
  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  parsed_data = JSON.parse(raw_data_string)

  # get the symbols from the JSON
  currency_hash = parsed_data.fetch("currencies")
  @symbols = currency_hash.keys()

  erb(:Conversion)

end

get("/:from_currency/:to_currency") do
  @original_currency = params.fetch("from_currency")
  @destination_currency = params.fetch("to_currency")

  api_url = "https://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATE_API"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
  
  # some more code to parse the URL and render a view template
  # use HTTP.get to retrieve the API information
  raw_data = HTTP.get(api_url)
 
  # convert the raw request to a string
  raw_data_string = raw_data.to_s

  # convert the string to JSON
  @parsed_data = JSON.parse(raw_data_string)

  erb(:Calculation)
end

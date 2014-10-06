require 'sinatra/base'

class my_app < Sinatra::Base
  get '/' do
    'Hello my_app!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end

class ApplicationController < Sinatra::Base
  get '/' do
    # index
    erb :index
  end
end

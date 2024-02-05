class ApplicationController < Sinatra::Base
  get '/' do
    # index
    erb :index
  end

  get '/gossips/new/' do
    # new_gossip.erb
    erb :new_gossip
    puts "Ce programme ne fait rien pour le moment, on va donc afficher un message dans le terminal"
  end
end

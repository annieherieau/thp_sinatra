require 'gossip'

class ApplicationController < Sinatra::Base
  # index
  get '/' do  
    erb :index, locals: {gossips: Gossip.all}
  end

  # page nouveau gossip : formulaire
  get '/gossips/new/' do
    erb :new_gossip
  end

  # enregistrement des données du formulaire dans la BDD
  post '/gossips/new' do
    Gossip.new(params['gossip_author'],params['gossip_content']).save
    redirect '/'
  end

  # afficher un gossip par son index
  get '/gossips/:gossip_id' do
    erb :show, locals: {gossip_id: params['gossip_id'].to_i, gossip: Gossip.find(params['gossip_id'].to_i)}
  end

  # page éditer un gossip : formulaire
  get '/gossips/:gossip_id/edit' do
    erb :edit, locals: {gossip_id: params['gossip_id'].to_i, gossip: Gossip.find(params['gossip_id'].to_i)}
  end

  # mise à jour du Gossip dans la BDD
  post '/gossips/:gossip_id/edit' do
    Gossip.update(params['gossip_id'].to_i, params['gossip_author'],params['gossip_content'])
    redirect '/'
  end

  # supprimer un gossip : formulaire
  get '/gossips/:gossip_id/suppr' do
    Gossip.delete(params['gossip_id'].to_i)
    redirect '/'
  end
end

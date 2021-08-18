require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require './lib/board'

also_reload 'lib/**/*.rb'

get '/boards' do
  '<h1>Boards list</h1>'
end

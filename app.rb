# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative 'lib/board.rb'
require_relative 'lib/boards_and_messages.rb'

also_reload 'lib/**/*.rb'

get '/boards' do
  @boards = Board.all.map(&:to_json)

  erb :boards
end

get '/start' do
  Board.clear
  BBS.new(boards_number: 5, messages_number: 10)

  redirect '/boards'
end

get '/boards/:id' do
  board = Board.find(params[:id].to_i)
  @data = board.to_json
  @messages_text = board.messages.map(&:text)

  erb :board
end

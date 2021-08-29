# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require './lib/board'

also_reload 'lib/**/*.rb'

get '/boards' do
  @boards = Board.all.map(&:to_json)

  erb :boards
end

get '/start' do
  Board.clear
  @board_titles = ('a'..'g').map { |code| "Board /#{code}/" }
  @board_titles.each { |title| Board.new(title: title).save }

  redirect '/boards'
end

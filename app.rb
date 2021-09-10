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
  Message.clear
  BBS.new(boards_number: 5, messages_number: 20)

  redirect '/boards'
end

get '/boards/:id' do
  board = Board.find(params[:id].to_i)
  @data = board.to_json
  @messages_text = board.messages.map(&:text)

  erb :board
end

get '/finds' do
  search_pattern = params[:'search-message']
  @finds = Board.search_messages(search_pattern).map do |record|
    {
      title: record[:title],
      messages: record[:messages].map { |id| Message.find(id).text }
    }
  end

  erb :finds
end

get '/finds/boards' do
  search_pattern = params[:'search-board']
  @finds = Board.search(title: search_pattern).map do |id|
    {
      title: Board.find(id).board.title
    }
  end

  erb :finds
end

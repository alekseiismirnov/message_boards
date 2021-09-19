# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require 'pry'

require_relative 'lib/board.rb'
require_relative 'lib/boards_and_messages.rb'

also_reload 'lib/**/*.rb'

get '/boards' do
  timestamp_sort = params[:timestamp_sort]
  @boards = Board.all.map(&:to_json)
  @boards.sort! { |a, b| b[:timestamp] <=> a[:timestamp] } if timestamp_sort == 'newest'
  @boards.sort! { |a, b| a[:timestamp] <=> b[:timestamp] } if timestamp_sort == 'oldest'

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
  timestamp_sort = params[:'timestamp-sort']
  @data = board.to_json
  @messages = board.messages.map(&:to_json)
  @messages.sort! { |a, b| a[:timestamp] <=> b[:timestamp] } if timestamp_sort == 'oldest'
  @messages.sort! { |a, b| b[:timestamp] <=> a[:timestamp] } if timestamp_sort == 'newest'

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
      title: Board.find(id).title
    }
  end

  erb :finds
end

patch '/boards/:board_id/messages/:id/update' do
  id = params[:id].to_i
  text = params[:message]

  Message.find(id).update(text: text)

  redirect "/boards/#{params[:board_id]}"
end

delete '/boards/:board_id/messages/:id' do
  board_id = params[:board_id].to_i
  id = params[:id].to_i
  Board.find(board_id).delete_message(id)

  redirect "/boards/#{board_id}"
end

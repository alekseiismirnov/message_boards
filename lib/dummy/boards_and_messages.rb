# frozen_string_literal: true

require 'humanize'

require 'board'
require 'message'

# it retns boards with messages, one empty, and inital data
class BBS
  attr_reader :bbs_data, :empty_board_index, :boards

  def initialize(boards_number:, messages_number:)
    @bbs_data = make_dummy_data(boards_number, messages_number)

    @empty_board_index = @bbs_data.length / 2
    @bbs_data[@empty_board_index][:messages] = []

    @boards = @bbs_data.map do |board_data|
      board = Board.new(title: board_data[:title])
      board.save
      board_data[:messages].each do |text|
        board.save_message text
      end
      
      board
    end
  end

  private

  def make_dummy_data(boards_number, messages_number)
    board_title_chunk = 'This is the board #'
    message_text_chunk = 'in my opinion it should be:'

    (1..boards_number).map do |i|
      {
        title: board_title_chunk + i.to_s,
        messages: (1..messages_number).map do |j|
                    "At #{i.humanize} #{message_text_chunk} #{j.humanize}!"
                  end
      }
    end
  end
end

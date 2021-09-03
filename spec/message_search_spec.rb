# frozen_string_literal: true

require 'board'
require 'boards_and_messages'

describe 'Message search' do
  before :all do
    Message.clear
    Board.clear
    @bbs = BBS.new(boards_number: 5, messages_number: 19)
  end

  context 'if no messages' do
    it 'return empty array' do
      search_result = @bbs
                      .empty_board
                      .search_messages('sample text')

      expect(search_result).to eq []
    end
  end
end

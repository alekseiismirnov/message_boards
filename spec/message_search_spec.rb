# frozen_string_literal: true

require 'board'
require 'boards_and_messages'

describe 'Message search' do
  before :all do
    Message.clear
    Board.clear
    @bbs = BBS.new(boards_number: 5, messages_number: 19)
  end

  context 'if no messages on board' do
    it 'returns empty array' do
      search_result = @bbs
                      .empty_board
                      .search_messages('sample text')

      expect(search_result).to eq []
    end
  end

  context 'there are some messages' do
    before :all do
      @board = @bbs.boards.first
      @for_all = 'in my opinion it should be:'
      @for_none = 'RNAb2 3E9E Vp. 1cNV0u D emgE2U'
      @for_seven = 'teen'
    end

    it 'finds none for not matched' do
      expect(@board.search_messages(@for_none)).to eq []
    end

    it 'finds all messages for matched to all' do 
      expect(@board.search_messages(@for_all).length).to eq 19
    end

    it 'finds only matched messages' do
      expect(@board.search_messages(@for_seven).length).to eq 7
    end
  end
end

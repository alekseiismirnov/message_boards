# frozen_string_literal: true

require 'board'

describe Board do
  context 'with default constructor' do
    # "default" in this progect means with the title as a parameter
    before :all do
      @title = 'Board Specificaton'
      @board = Board.new(title: @title)
    end

    it 'board has a title' do
      expect(@board.title).to eq @title
    end

    it '#messages returns an empty list of messages' do
      expect(@board.messages).to eq []
    end

    context 'message added' do
      before :all do
        @text = 'Single message, not too long'
        @board.save_message @text
      end

      it '#messages returns list with one message' do
        expect(@board.messages.length).to eq 1
      end
    end
  end
end

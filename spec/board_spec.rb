# frozen_string_literal: true

require 'board'

describe Board do
  context 'with default constructor' do
    # "default" in this progect means with the title as a parameter
    before :all do
      @title = 'Board Specificaton'
      @board = Board.new(title: @title)
    end

    it 'has a title' do
      expect(@board.title).to eq @title
    end
  end
end

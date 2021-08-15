# frozen_string_literal: true

require 'board'

describe Board do
  before :all do
    @title = 'Board To save'
    @board = Board.new(title: @title)
  end

  context 'board is not saved' do
    it 'list of all boards is empty' do
      expect(Board.all).to eq []
    end
  end

  context 'board is saved' do
    before :all do
      @board.save
    end

    it 'list of all boards has length 1' do
      expect(Board.all.length).to eq 1
    end
  end
end

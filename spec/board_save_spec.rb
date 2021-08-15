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
end

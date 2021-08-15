# frozen_string_literal: true

# roghly same as the 'board_save_spec' but for multiply instances
require 'board'

describe Board do
  before :all do
    Board.clear
    @boards_number = 100
    @boards = (1..@boards_number).map do |number|
      # We'll have 10 non-grupped sets of 10 same names
      title = "Board To Save, Code #{number % 10}"
      Board.new(title: title)
    end
  end

  context 'boards are not saved' do
    it 'list of all boards is empty' do
      expect(Board.all).to eq []
    end
  end

  context 'one board is saved' do
    Board.clear
    before :all do
      @boards.each(&:save)
    end

    it 'list of all boards has length 100' do
      expect(Board.all.length).to eq @boards_number
    end

    it 'saved boards are is in the returned list' do
      expect(Board.all.sort).to eq @boards.sort
    end
  end
end

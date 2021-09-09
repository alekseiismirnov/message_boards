# frozen_string_literal: true

require 'capybara/rspec'
require './app'
require 'board'

Capybara.app = Sinatra::Application
set(show_exception: false)

Capybara.save_path = '~/tmp'

describe('Messages search', type: :feature) do
  before :all do
    Message.clear
    Board.clear
    @bbs = BBS.new(boards_number: 15, messages_number: 21)
    @finds_numbers = {
      'At two in my opinion it should be: six!' => 1,
      'in my opinion it should be: ten!' => 14,
      'teen' => 105
    }
  end

  context 'only some of the messages are finded' do
    it 'there are no empty board titles in search results' do
      @finds_numbers.keys.each do |pattern|
        visit '/boards'
        fill_in('search-message', with: pattern)
        click_button 'Search Message'
        expect(page).to have_no_content @bbs.empty_board.title
      end
    end
  end
end

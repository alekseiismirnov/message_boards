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
  end

  context 'Board list page' do
    it 'there is a message search field on it' do
      visit '/boards'

      within '.footer' do
        expect(page).to have_field('Search Message', type: 'text')
      end
    end
  end

  context 'Search result page' do
    it 'there is `nothing found` for unfoundable pattern'
    it 'there are boards with founded messages'
    it 'there are messages with foundable pattern'
  end
end

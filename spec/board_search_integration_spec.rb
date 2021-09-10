require 'capybara/rspec'
require './app'
require 'board'

Capybara.app = Sinatra::Application
set(show_exception: false)

Capybara.save_path = '~/tmp'

describe('Boards search', type: :feature) do
  before :all do
    Message.clear
    Board.clear
    @bbs = BBS.new(boards_number: 15, messages_number: 21)
  end

  context 'if no such board' do
    it 'there is `Nothing found` sighn in result page' do
      visit '/boards'
      fill_in('search-board', with: 'whatever random stuff')
      click_button 'Search Board'

      within '.search-results' do
        expect(page).to have_content 'Nothing found'
      end
    end
  end
end

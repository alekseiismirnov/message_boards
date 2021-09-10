# frozen_string_literal: true

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

  context 'there is some board to find' do
    before :each do
      visit '/boards'
      fill_in('search-board', with: 'board #5')
      click_button 'Search Board'
    end

    it 'there is board title on result page' do
      within '.search-results' do
        expect(page).to have_content 'This is the board #5'
      end
    end

    it 'there are no another titles' do
      @bbs.boards.map(&:title).delete('This is the board #5') do |title|
        expect(page).to have_no_content title
      end
    end
  end

  context 'there are several boards to find' do
    before :each do
      @titles_to_find = @bbs
                        .boards
                        .select { |board| board.title.include? 'board #1' }
                        .map(&:title)
      visit '/boards'
      fill_in('search-board', with: 'board #1')
      click_button 'Search Board'
    end

    it 'there are all findable titles on the page result' do
      @titles_to_find.each do |title|
        within '.search-results' do
          expect(page).to have_content title
        end
      end
    end
  end
end

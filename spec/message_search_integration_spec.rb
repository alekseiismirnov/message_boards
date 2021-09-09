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
    @for_all = 'in my opinion it should be:'
    @for_none = 'RNAb2 3E9E Vp. 1cNV0u D emgE2U'
  end

  context 'at board list page' do
    it 'there is a message search field on it' do
      visit '/boards'

      within '.footer' do
        expect(page).to have_field('search-message', type: 'text')
      end
    end
  end

  context 'at search result page' do
    it 'there is `nothing found` for unfoundable pattern' do
      visit '/boards'
      fill_in 'search-message',	with: @for_none
      click_button 'Search Message'

      within '.search-results' do
        expect(page).to have_content 'Nothing found'
      end
    end

    it 'there are board titles with found messages if any' do
      visit '/boards'
      fill_in 'search-message',	with: @for_all
      click_button 'Search Message'

      within '.search-results' do
        @bbs.boards
            .reject { |board| board.messages.empty? }
            .map(&:title).each do |title|
          expect(page).to have_content title
        end
      end
    end

    it 'there are found messages if any' do
      visit '/boards'
      fill_in 'search-message',	with: @for_all
      click_button 'Search Message'

      within '.search-results' do
        @bbs.bbs_data.map { |board| board[:messages] }.flatten.each do |message|
          expect(page).to have_content message
        end
      end
    end
  end
end

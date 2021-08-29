# frozen_string_literal: true

require 'capybara/rspec'
require './app'
require 'board'

Capybara.app = Sinatra::Application
set(show_exception: false)

Capybara.save_path = '~/tmp'

describe('Boards list', type: :feature) do
  context 'no boards' do
    before :each do
      Board.clear
      visit '/boards'
    end
    it 'there is a title' do
      within 'h1' do
        expect(page).to have_content 'Boards list'
      end
    end

    it 'there is `no boards` sign' do
      within '.boards_portal' do
        expect(page).to have_content 'No boards yet'
      end
    end
  end

  context 'there are some boards' do
    before :each do
      Board.clear
      @board_titles = ('a'..'g').map { |code| "Board /#{code}/" }
      @board_titles.each { |title| Board.new(title: title).save }
      visit '/boards'
    end

    it 'there is a list of all boards titles' do
      within('.boards_portal') do
        titles = all('li').map(&:text)

        expect(titles).to match_array @board_titles
      end
    end
  end
end

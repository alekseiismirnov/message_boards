# frozen_string_literal: true

require 'capybara/rspec'

require './app'
require 'board'
require 'message'

require 'boards_and_messages'

Capybara.app = Sinatra::Application
set(show_exception: false)

Capybara.save_path = '~/tmp'

describe('Message board', type: :feature) do
  before :all do
    @bbs = BBS.new(boards_number: 5, messages_number: 10)
  end

  it 'is accessible from the boards list' do
    result_codes = @bbs.bbs_data.map do |board|
      visit '/boards'
      click_on board[:title]
      page.status_code
    end

    expect(result_codes.all? { |code| code == 200 }).to be true
  end

  it 'has a title' do
    board = @bbs.boards.last
    visit "/boards/#{board.id}"
    expect(page).to have_title board.title
  end

  it 'has `no messages` sign if has no messages' do
    visit "/boards/#{@bbs.empty_board_index}"

    within '.messages' do
      expect(page).to have_content 'No messages yet'
    end
  end

  it 'has messages saved on it' do
    board = @bbs.boards.first
    messages = board.messages.map(&:text)

    visit "/boards/#{board.id}"
    within '.messages' do
      expect(page.all(class: 'message-text').map(&:text)).to match_array messages
    end
  end
end

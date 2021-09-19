# frozen_string_literal: true

require 'capybara/rspec'

require './app'
require 'board'
require 'message'

require 'boards_and_messages'

Capybara.app = Sinatra::Application
set(show_exception: false)

Capybara.save_path = '~/tmp'

describe('Delete', type: :feature) do
  before :all do
    visit '/boards'
    click_on 'Login'
  end

  context 'board page' do
    before :each do
      Board.clear
      Message.clear

      @bbs = BBS.new(boards_number: 3, messages_number: 5)
      @delete_this = @bbs.boards[0].messages[3].text
      @board_id = @bbs.boards[0].id

      visit "/boards/#{@board_id}"
    end

    it 'there is no message after its delete' do
      within(find('.message-text', text: @delete_this).ancestor('.message')) do
        click_button 'Delete'
      end

      within('.messages') do
        expect(page).to have_no_content @delete_this
      end
    end
  end
end

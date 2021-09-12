# frozen_string_literal: true

require 'capybara/rspec'
require './app'
require 'board'

Capybara.app = Sinatra::Application
set(show_exception: false)

Capybara.save_path = '~/tmp'

describe('Messages update', type: :feature) do
  before :all do
    Message.clear
    Board.clear
    @bbs = BBS.new(boards_number: 15, messages_number: 21)
    @message_to_change = 'At two in my opinion it should be: four!'
    @message_new = 'Something compleatly different'

    visit '/boards'
    click_on 'This is the board #2'

    within page.find('.message', text: @message_to_change) do
      fill_in('message', with: @message_new)
      click_button 'Update Message'
    end
  end

  before :each do
    visit '/boards'
    click_on 'This is the board #2'
  end

  it 'removes old message' do
    expect(page).to have_no_content @message_to_change
  end

  it 'adds new message' do
    expect(page).to have_content @message_new
  end
end

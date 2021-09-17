# frozen_string_literal: true

require 'capybara/rspec'

require './app'
require 'board'
require 'message'

require 'boards_and_messages'

Capybara.app = Sinatra::Application
set(show_exception: false)

Capybara.save_path = '~/tmp'

class Board
  def shuffle_messages!
    @message_ids.shuffle!
    save
  end
end

class Message
  def self.timestamps_row!(ids)
    timestamp_start = Time.now
    ids.each.with_index do |id, index|
      @my_objects[id].update(timestamp: timestamp_start + index)
    end
  end
end

class Board
  def rewrite_timestamps!
    Message.timestamps_row! @message_ids
  end
end

describe('Sort', type: :feature) do
  context 'board page' do
    before :each do
      Board.clear
      Message.clear

      @bbs = BBS.new(boards_number: 3, messages_number: 9)
      @titles = @bbs.boards.first.messages.map(&:text)
      @bbs.boards.first.rewrite_timestamps!
      @bbs.boards.first.shuffle_messages!

      visit '/boards/1'
    end

    it 'can be sorted from oldest to newest' do
      click_button 'Newest first'
      expect(all('.message-text').map(&:text)).to eq @titles.reverse
    end

    # this is even worse test, good only for check if there is a button
    # and press on it doesn't ruin everything
    xit 'can be sorted from newest to oldest' do
      click_button 'Oldest first'
      titles = all('li').map(&:text)
      expect(titles).to eq @bbs.boards.map(&:title)
    end
  end
end

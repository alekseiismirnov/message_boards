# frozen_string_literal: true

require 'capybara/rspec'

require './app'
require 'board'
require 'message'

require 'boards_and_messages'

Capybara.app = Sinatra::Application
set(show_exception: false)

Capybara.save_path = '~/tmp'

describe('Login', type: :feature) do
  context 'not logged' do
    it 'after login on boards list page we have information about logged user' do
      visit '/boards'

      within('.header') do
        click_on 'Login'

        expect(page).to have_content 'Logged as an admin'
      end
    end
  end
end

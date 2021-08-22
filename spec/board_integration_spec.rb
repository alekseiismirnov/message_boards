# frozen_string_literal: true

require 'capybara/rspec'
require './app'
require 'board'

Capybara.app = Sinatra::Application
set(show_exception: false)

Capybara.save_path = '~/tmp'

describe('Boards list', type: :feature) do
  before :each do
    visit '/boards'
  end

  context 'no boards' do
    it 'there is a title' do
      within 'h1' do
        expect(page).to have_content 'Boards list'
      end
    end

    it 'there is `no boards` sign' do
      within '.boards' do
        expect(page).to have_content 'No boards yet'
      end
    end
  end
end

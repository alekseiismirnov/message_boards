# frozen_string_literal: true

require 'message'

describe Message do
  before :all do
    @text = 'Test message text'
    @message = Message.new(text: @text)
  end
  context 'with default construction' do
    it 'contains a text' do
      expect(@message.text).to eq @text
    end
  end
end

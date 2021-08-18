# frozen_string_literal: true

require 'message'

describe Message do
  before :all do
    @text = 'Test message text'
    @message = Message.new(text: @text)
    @message.save
  end

  context 'with default constructor' do
    it 'contains a text' do
      expect(@message.text).to eq @text
    end

    it 'text can be updated' do
      @updated_text = 'New text' 
      @message.update(text: @updated_text)
      expect(Message.find(@message.id).text).to eq @updated_text
    end
  end
end

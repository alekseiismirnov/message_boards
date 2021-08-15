# frozen_string_literal: true

# kind of a wrapper around the string
class Message
  attr_reader :text

  def initialize(params)
    @text = params[:text]
  end
end

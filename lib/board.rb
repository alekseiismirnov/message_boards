# frozen_string_literal: true

# titled container for messages
class Board
  attr_reader :title

  def initialize(params)
    @title = params[:title]
  end

  def messages
    []
  end
end

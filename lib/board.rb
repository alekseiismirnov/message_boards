# frozen_string_literal: true

# titled container for messages
class Board
  attr_reader :title, :id

  @boards = {}
  @last_id = 0

  def initialize(params)
    @title = params[:title]
    @id = params[:id] || self.class.free_id
  end

  def self.all
    @boards.values # if we change object from this list, we change saved object
  end

  def self.save_me(my_object)
    @boards[my_object.id] = my_object.clone
  end

  def self.free_id
    @last_id += 1
  end

  def clone
    self.class.new(title: @title, id: @id)
  end

  def messages
    []
  end

  def save
    self.class.save_me self
  end

  def ==(other)
    @title = other.title
  end
end

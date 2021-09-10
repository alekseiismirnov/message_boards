# frozen_string_literal: true

# titled container for messages
class Board
  attr_reader :title, :id

  @boards = {}
  @last_id = 0

  def initialize(params)
    @title = params[:title]
    @id = params[:id] || self.class.free_id
    @message_ids = params[:message_ids] || []
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

  def self.clear
    @boards = {}
    @last_id = 0
  end

  def self.find(id)
    @boards[id].clone
  end

  def self.search_messages(search_pattern)
    Board.all.map do |board|
      found_message_ids = board.search_messages(search_pattern)
      next if found_message_ids.empty?

      {
        title: board.title,
        messages: found_message_ids
      }
    end
         .reject(&:nil?)
  end

  def self.search(params)
    # only for titles, obviously
    pattern = params[:title]

    Board.all
         .select { |board| board.title.include?(pattern) }
         .map(&:id)
  end

  def clone
    self.class.new(
      title: @title,
      id: @id,
      message_ids: @message_ids.clone
    )
  end

  def messages
    @message_ids.map { |id| Message.find id }
  end

  def save
    self.class.save_me self
  end

  def ==(other)
    @title = other.title
  end

  def <=>(other)
    @title <=> other.title
  end

  def save_message(text)
    message = Message.new(text: text)
    message.save

    @message_ids << message.id

    save
  end

  def to_json(*_args)
    {
      title: title,
      id: id,
      message_ids: @message_ids.clone
    }
  end

  def search_messages(text)
    Message.search(text: text, within: @message_ids)
  end
end

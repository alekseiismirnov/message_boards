# frozen_string_literal: true

# kind of a wrapper around the string
class Message
  attr_reader :text, :id

  @my_objects = {}
  @last_id = 0

  def initialize(params)
    @text = params[:text]
    @id = params[:id] || self.class.free_id
  end

  def self.save_me(my_object)
    @my_objects[my_object.id] = my_object.clone
  end

  def self.clear
    @my_objects = {}
    @last_id = 0
  end

  def self.free_id
    @last_id += 1
  end

  def self.find(id)
    @my_objects[id].clone
  end

  def self.search(params)
    pattern = params[:text]
    within = params[:within]

    (within.nil? ? @my_objects.values : @my_objects.values_at(*within))
      .select { |message| message.text.include?(pattern) }
      .map(&:id)
  end

  def save
    self.class.save_me self
  end

  def clone
    self.class.new(text: text, id: id)
  end

  def update(params)
    @text = params[:text] if params[:text]
    save
  end

  def to_json(*_args)
    {
      id: @id,
      text: @text
    }
  end
end

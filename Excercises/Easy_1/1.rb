class Banner
  attr_reader :message, :width

  def initialize(message, width=(message.length))
    @message = message
    width >= message.length ? @width = width : @width = message.length
  end

  def to_s
    [horizontal_rule, 
      empty_line,
      message_line, 
      empty_line, 
      horizontal_rule]
      .join("\n")
  end

  private

  def horizontal_rule
    "+ #{'-' * width} +"
  end

  def empty_line
    "| #{' ' * width} |"
  end

  def message_line
    padding = ' ' * ((width - message.length) / 2) + ' '

    "|#{padding}#{@message}#{padding}|"
  end
end

banner = Banner.new('Message', 15)
puts banner



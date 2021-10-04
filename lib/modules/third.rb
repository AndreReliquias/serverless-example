class Third
  def execute(event)
    puts "I'm the third function"
    puts "I received the message:\n#{event['message']['stringValue']}"
  end
end
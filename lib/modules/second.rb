require_relative '../shared/sqs'

class Second
  include Sqs

  def execute(event)
    begin
      puts 'Im the second function :)'
      puts "I received the message:\n#{event['message']['stringValue']}"
      
      message_attributes = {
        "message" => {
          string_value: 'Hey, this message will be received by the third function!',
          data_type: 'String'
        }
      }

      Sqs.send_message(
        'mySecondQueue',
        ENV['QUEUE_URL'],
        message_attributes
      )
    rescue => error
      puts "Error second.rb: #{error}"
    end
  end
end
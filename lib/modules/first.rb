require_relative '../shared/sqs'

class First
  include Sqs

  def execute
    begin
      puts 'Im the first function :)'

      message_attributes = {
        "message" => {
          string_value: 'Hey, this message will be received by the second function!',
          data_type: 'String'
        }
      }

      Sqs.send_message(
        'myFirstQueue',
        ENV['QUEUE_URL'],
        message_attributes
      )

      'Message sended successfully!'
    rescue => error
      puts "Error first.rb: #{error}"
    end
  end
end
require 'aws-sdk-sqs'

module Sqs
  def self.send_message(queue_name, queue_url, message_attributes)
    begin
      if ENV['OFFLINE'] == 'true'
        sqs = Aws::SQS::Client.new(
          region: ENV['REGION'],
          endpoint: 'http://0.0.0.0:9324',
          access_key_id: 'root',
          secret_access_key: 'root'
        )
  
        queue_url = sqs.get_queue_url(queue_name: queue_name).queue_url
        puts queue_url
      else
        sqs = Aws::SQS::Client.new(region: ENV['REGION'])

        if queue_url.nil?
          sts_client = Aws::STS::Client.new(region: ENV['REGION'])
          # queue_url = "https://sqs.#{ENV['REGION']}.amazonaws.com/#{sts_client.get_caller_identity[:account]}/#{ENV['PREFIX']}-#{queue_name}"
          queue_url = "https://sqs.#{ENV['REGION']}.amazonaws.com/#{sts_client.get_caller_identity[:account]}/#{queue_name}"
        end
      end

      message = {
        queue_url: queue_url,
        message_body: 'New item',
        message_attributes: message_attributes
      }

      sqs.send_message(message)
    rescue => error
      puts "Error sqs.rb: #{error}"
    end
  end
end
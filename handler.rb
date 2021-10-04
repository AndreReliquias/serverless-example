require_relative './lib/modules/first'
require_relative './lib/modules/second'
require_relative './lib/modules/third'


def first_function(event:, context:)
  First.new.execute
end

def second_function(event:, context:)
  Second.new.execute(event['Records'].first['messageAttributes'])
end

def third_function(event:, context:)
  Third.new.execute(event['Records'].first['messageAttributes'])
end

# require_relative "../../config/application"
desc 'Call GPT instance'
task chat: :environment do
    p "Enter message"
    message = STDIN.gets.chomp()
    p GptService.new(message, true).handle_message
end

desc 'Get sentiment'
task sentiment: :environment do
    p "Enter message"
    message = STDIN.gets.chomp()
    p GptService.new(message, true).sentiment_analysis
end
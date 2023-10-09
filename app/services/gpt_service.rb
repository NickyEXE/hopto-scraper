class GptService
  attr_reader :client, :message

  def initialize(message)
    @client = OpenAI::Client.new
    @message = message
  end

  def handle_message
    unless ENV.has_key?("DISABLE_BOT") && ENV.fetch("DISABLE_BOT") == "TRUE"
      sentiment_analysis == "TRUE" && snarky_response
    end
  end

  def sentiment_analysis
    chat(File.read("lib/prompts/sentiment.txt"), "gpt-3.5-turbo")
  end

  def snarky_response
    chat(File.read("lib/prompts/hoptobot.txt"), "gpt-4")
  end

  def chat(prompt, model)
    response = client.chat(
    parameters: {
        model: model, # Required.
        messages: [{ role: "system", content: prompt}, {role: "user", content: message}], # Required.
        temperature: 0.9,
    })
    response["choices"][0]["message"]["content"]
  end
end
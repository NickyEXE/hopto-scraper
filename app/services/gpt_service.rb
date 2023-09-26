class GptService
  attr_reader :client, :message

  def initialize(message)
    @client = OpenAI::Client.new
    @message = message
  end

  def chat
    response = client.chat(
    parameters: {
        model: "gpt-3.5-turbo", # Required.
        messages: [{ role: "system", content: File.read("lib/prompts/sentiment.txt")}, role: "user", content: message], # Required.
        temperature: 0.9,
    })
    answer = response["choices"][0]["message"]["content"]
  end
end
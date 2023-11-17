class GptService
  attr_reader :client, :message, :guarantee_response

  def initialize(message, guarantee_response = false)
    @client = OpenAI::Client.new
    @message = message
    @guarantee_response = guarantee_response
  end

  def handle_message
    unless ENV.has_key?("DISABLE_BOT") && ENV.fetch("DISABLE_BOT") == "TRUE"
      if sentiment_analysis
        chat(Prompt.current_prompt, "gpt-4")
      end
    end
  end

  def sentiment_analysis
    guarantee_response == true || chat(File.read("lib/prompts/sentiment.txt"), "gpt-3.5-turbo") == "TRUE"
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
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
        if ENV.fetch("PERSONALITY") == "evil"
          snarky_response
        elsif ENV.fetch("PERSONALITY") == "maliciously_kind"
          maliciously_kind_response
        end
      end
    end
  end

  def sentiment_analysis
    guarantee_response == "TRUE" || chat(File.read("lib/prompts/sentiment.txt"), "gpt-3.5-turbo") == "TRUE"
  end

  def snarky_response
    chat(File.read("lib/prompts/evil.txt"), "gpt-4")
  end

  def maliciously_kind_response
    chat(File.read("lib/prompts/maliciously_kind.txt"), "gpt-4")
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
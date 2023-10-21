class MessagesController < ApplicationController
  def snark_gpt
    response = GptService.new(params["message"], params["guarantee_response"]).handle_message
    render json: {messages: response, has_response: !!response}
  end
end

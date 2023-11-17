class PromptsController < ApplicationController

  def index
    render json: Prompt.all
  end

  def create
    prompt = Prompt.smart_create(params[:name], params[:prompt])
    if prompt.valid?
      render json: prompt
    else
      render json: {error: prompt.errors.full_messages.to_sentence}
    end
  end

  def set_prompt
    prompt = Prompt.find_by(id: params[:id])
    if prompt
      Prompt.update_all(enabled: false)
      prompt.update(enabled: true)
      render json: prompt
    else
      render json: {error: "Could not find prompt with that id"}, status: 404
    end
  end
end

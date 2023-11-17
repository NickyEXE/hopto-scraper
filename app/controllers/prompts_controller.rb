class PromptsController < ApplicationController

  def index
    render json: Prompt.all
  end

  def create
    prompt = Prompt.create(name: params[:name], prompt: params[:prompt])
    prompt.enable!
    render json: prompt
  end

  def set_prompt
    prompt = Prompt.find_by(id: params[:id])
    if prompt
      prompt.enable!
      render json: prompt
    else
      render json: {error: "Could not find prompt with that id"}, status: 404
    end
  end
end

class CancelsController < ApplicationController

  def leaderboard
    render json: {messages: Cancel.leaderboard_messages}
  end
end

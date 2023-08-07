class UsersController < ApplicationController

  def cancel
    cancelled_user = User.find_or_create_by(discord_id: params["cancelled_member"]["discord_id"]) do |u|
      u.username = params["cancelled_member"]["username"]
    end
    cancelling_user = User.find_or_create_by(discord_id: params["cancelling_member"]["discord_id"]) do |u|
      u.username = params["cancelling_member"]["username"]
    end
    cancelling_user.cancel_user(cancelled_user)
    render json: {messages: [
      "#{cancelled_user.username} has been cancelled by #{cancelling_user.username}.",
      "#{cancelled_user.username} has been cancelled #{cancelled_user.cancelleds.length} times by #{cancelled_user.cancelling_users.length} users.",
      "type !cancellation_status <tagged user> to see full data on a user's cancellations, or !cancellation_leaderboard to see the leaderboard."
    ]}
  end

  def cancellation_status
    user = User.find_by_discord_id(params[:discord_id])
    if user
      render json: {messages: user.cancellation_data_messages}
    else
      render json: {messages: ["User has not been cancelled yet."]}
    end
  end

end

class UsersController < ApplicationController

  def cancel
    binding.pry
    cancelled_user = User.find_or_create_by(discord_id: params["cancelled_member"]["discord_id"]) do |u|
      u.username = params["cancelled_member"]["username"]
    end
    cancelling_user = User.find_or_create_by_discord_id(params["cancelling_member"]["discord_id"]) do |u|
      u.username = params["cancelling_member"]["username"]
    end
  end

end

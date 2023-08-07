class Cancel < ApplicationRecord
  belongs_to :canceller, class_name: "User"
  belongs_to :cancellee, class_name: "User"

  def self.leaderboard
    leaderboard = {}
    all.each do |cancel|
      leaderboard[cancel.cancellee_id] ? leaderboard[cancel.cancellee_id] += 1 : leaderboard[cancel.cancellee_id] = 1 
    end
    leaderboard.map do |id, count|
      [User.find(id).username, count]
    end.sort_by{|arr| -arr[1]}
  end

  def self.leaderboard_messages
    messages = ["The following users are the most cancelled:"]
    leaderboard.each do |user, count|
      messages.push("* #{user}: #{count}")
    end
    messages
  end
end

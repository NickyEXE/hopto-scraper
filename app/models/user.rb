class User < ApplicationRecord
  has_many :cancelleds, foreign_key: :cancellee_id, class_name: "Cancel"
  has_many :cancelling_users, through: :cancelleds, source: :canceller

  has_many :cancels, foreign_key: :canceller_id, class_name: "Cancel"
  has_many :cancelled_users, through: :cancels, source: :cancellee

  def cancel_user(user)
    Cancel.create(canceller: self, cancellee: user)
  end

  def cancellation_data
    users = {}
    cancelling_users.each do |user|
      users[user["username"]] ? users[user["username"]] += 1 : users[user["username"]] = 1
    end
    users.map{|key, val| [key, val]}.sort_by{|arr| -arr[1]}
  end

  def cancellation_data_messages
    messages = ["#{username} has been cancelled #{cancelling_users.length} times by the following users:"]
    cancellation_data.each do |user, count|
      messages.push("* #{user}: #{count} times")
    end
    messages
  end
end

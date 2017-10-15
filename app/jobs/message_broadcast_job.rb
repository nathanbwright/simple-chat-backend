class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, username)
    Message.create! message: message, username: username
    ActionCable.server.broadcast "room_channel", message: "#{username}: #{message}"
  end
end

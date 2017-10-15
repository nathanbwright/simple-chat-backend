class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    MessageBroadcastJob.perform_later(data["message"], @username)
  end

  def join_room(data)
    @username = data.fetch("username") || "Anonymous"
    ActionCable.server.broadcast "room_channel", message: "#{@username} has joined the chat."
  end

  def leave_room(data)
    ActionCable.server.broadcast "room_channel", message: "#{@username} has left the chat."
  end
end

class GameChannel < ApplicationCable::Channel
  def subscribed
    stream_from "game_channel"
    ApplicationCable::Connection.add_user(current_user)
    broadcast_users_list
  end

  def roll_dice(data)
    ActionCable.server.broadcast "game_channel", { value: rand(1..6), player: data["player"] }
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    ApplicationCable::Connection.remove_user(current_user)
    broadcast_users_list
  end

  private
    def broadcast_users_list
      users = ApplicationCable::Connection.connected_users
      serialized_users = ActiveModelSerializers::SerializableResource.new(users, each_serializer: UserSerializer).to_json
      ActionCable.server.broadcast "users", users: serialized_users
    end
end

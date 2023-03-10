class UsersChannel < ApplicationCable::Channel
  def subscribed
    stream_from "users"
    broadcast_authenticated_users
  end

  def unsubscribed
    broadcast_authenticated_users
  end

  private

  def broadcast_authenticated_users
    users = warden.user(scope: :user)
    ActionCable.server.broadcast "users", users: users
  end
end

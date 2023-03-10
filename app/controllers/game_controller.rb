class GameController < ApplicationController
  def index
      @users_channel = UsersChannel.broadcast_to(current_user, { message: 'Hello from the server!' })
  end
end

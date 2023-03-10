module ApplicationCable
    class Connection < ActionCable::Connection::Base
        identified_by :current_user

        def connect
            self.current_user = find_verified_user
            logger.add_tags 'ActionCable', current_user.email
        end

        def disconnect
            # Remove the current user from the array of connected users
            connected_users.delete(current_user)
        end

        def connected_users
            # Return the array of connected users
            self.class.connected_users
        end

        protected
        def find_verified_user
            if verified_user = env['warden'].user
                verified_user
            else
                reject_unauthorized_connection
            end
        end

        def self.connected_users
            @@connected_users ||= []
        end

        def self.add_user(user)
            @@connected_users << user
        end

        def self.remove_user(user)
            @@connected_users.delete(user)
        end
    end    
end

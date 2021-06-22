module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user
    
    def connect
        self.current_user = find_verified_user
        logger.add_tags 'ActionCable', current_user.email       
    end

    protected
    def find_verified_user
        if verified_user = env["warden"].user(:professionnel)
          verified_user
        elsif verified_user = env["warden"].user(:client)
          verified_user    
        else
          reject_unauthorized_connection
        end
    end

  end
end
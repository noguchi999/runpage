class TestUsers
  class << self
    
    def find_or_create
      test_users.list[0] || test_user
    end
    
    def find_all
      test_users
    end
    
    private
      def test_users
        Koala::Facebook::TestUsers.new(app_id: Facebook::APP_ID.to_s, secret: Facebook::SECRET.to_s)
      end
        
      def test_user
        test_users.create(app_installed?, permissions)
      end
    
      def app_installed?
        true
      end
      
      def permissions
        %w[publish_stream email offline_access read_stream]
      end
  end
end

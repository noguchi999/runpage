module ScenariosHelper

  def oauth
    @oauth ||= Koala::Facebook::OAuth.new
  end
  
  def facebook_cookies
    @facebook_cookies ||= TestUsers.find_or_create
  end
  
  def access_token
    facebook_cookies["access_token"]
  end
  
  def graph
    @graph ||= Koala::Facebook::API.new(access_token)
  end
end

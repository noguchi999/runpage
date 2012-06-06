module UsersHelper
  
  def current_user
    return @current_user unless @current_user.nil?
    
    me = graph.get_object("me").symbolize_keys
    @current_user = User.find_or_create_by(fb_id: me[:id], fb_name: me[:name])
  end
end

class User
  include Mongoid::Document
  field :fb_id, :type => String
  field :fb_name, :type => String
end

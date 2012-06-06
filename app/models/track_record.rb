class TrackRecord
  include Mongoid::Document
  field :user_id, :type => String
  field :scenario_name, :type => String
  field :action, :type => String
  field :execute_at, :type => Time
end

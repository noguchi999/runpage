class Scenario
  include Mongoid::Document
  field :name, :type => String
  field :user_id, :type => String
  field :create_at, :type => Time
  field :execute_at, :type => Time
  
  embeds_many :testcases
  
  accepts_nested_attributes_for :testcases
end
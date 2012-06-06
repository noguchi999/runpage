class Testcase
  include Mongoid::Document
  field :name, :type => String
  field :action, :type => String
  field :status, :type => String
  
  embedded_in :scenario, :inverse_of => :testcases
end

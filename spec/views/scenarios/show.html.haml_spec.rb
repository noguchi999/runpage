require 'spec_helper'

describe "scenarios/show" do
  before(:each) do
    @scenario = assign(:scenario, stub_model(Scenario,
      :name => "Name",
      :user_id => "User"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/User/)
  end
end

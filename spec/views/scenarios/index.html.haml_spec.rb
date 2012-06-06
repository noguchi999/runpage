require 'spec_helper'

describe "scenarios/index" do
  before(:each) do
    assign(:scenarios, [
      stub_model(Scenario,
        :name => "Name",
        :user_id => "User"
      ),
      stub_model(Scenario,
        :name => "Name",
        :user_id => "User"
      )
    ])
  end

  it "renders a list of scenarios" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "User".to_s, :count => 2
  end
end

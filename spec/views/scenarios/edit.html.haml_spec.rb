require 'spec_helper'

describe "scenarios/edit" do
  before(:each) do
    @scenario = assign(:scenario, stub_model(Scenario,
      :name => "MyString",
      :user_id => "MyString"
    ))
  end

  it "renders the edit scenario form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => scenarios_path(@scenario), :method => "post" do
      assert_select "input#scenario_name", :name => "scenario[name]"
      assert_select "input#scenario_user_id", :name => "scenario[user_id]"
    end
  end
end

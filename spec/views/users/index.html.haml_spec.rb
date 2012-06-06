require 'spec_helper'

describe "users/index" do
  before(:each) do
    assign(:users, [
      stub_model(User,
        :fb_id => "Fb",
        :fb_name => "Fb Name"
      ),
      stub_model(User,
        :fb_id => "Fb",
        :fb_name => "Fb Name"
      )
    ])
  end

  it "renders a list of users" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Fb".to_s, :count => 2
    assert_select "tr>td", :text => "Fb Name".to_s, :count => 2
  end
end

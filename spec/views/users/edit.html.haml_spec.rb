require 'spec_helper'

describe "users/edit" do
  before(:each) do
    @user = assign(:user, stub_model(User,
      :fb_id => "MyString",
      :fb_name => "MyString"
    ))
  end

  it "renders the edit user form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => users_path(@user), :method => "post" do
      assert_select "input#user_fb_id", :name => "user[fb_id]"
      assert_select "input#user_fb_name", :name => "user[fb_name]"
    end
  end
end

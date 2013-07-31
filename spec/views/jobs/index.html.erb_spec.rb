require 'spec_helper'

describe "jobs/index" do
  before(:each) do
    assign(:jobs, [
      stub_model(Job,
        :user_id => 1,
        :title => "Title",
        :description => "Description",
        :category_id => 2,
        :subcategory_id => 3
      ),
      stub_model(Job,
        :user_id => 1,
        :title => "Title",
        :description => "Description",
        :category_id => 2,
        :subcategory_id => 3
      )
    ])
  end

  it "renders a list of jobs" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end

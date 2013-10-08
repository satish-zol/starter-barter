require 'spec_helper'

describe "jobs/new" do
  before(:each) do
    assign(:job, stub_model(Job,
      :user_id => 1,
      :title => "MyString",
      :description => "MyString",
      :category_id => 1,
      :subcategory_id => 1
    ).as_new_record)
  end

  it "renders new job form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => jobs_path, :method => "post" do
      assert_select "input#job_user_id", :name => "job[user_id]"
      assert_select "input#job_title", :name => "job[title]"
      assert_select "input#job_description", :name => "job[description]"
      assert_select "input#job_category_id", :name => "job[category_id]"
      assert_select "input#job_subcategory_id", :name => "job[subcategory_id]"
    end
  end
end

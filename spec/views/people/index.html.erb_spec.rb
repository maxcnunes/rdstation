require 'spec_helper'

describe "people/index" do
  before(:each) do
    assign(:people, [
      stub_model(Person,
        :name => "Name",
        :last_name => "Last Name",
        :email => "Email",
        :company => "Company",
        :job_title => "Job Title",
        :phone => "Phone",
        :website => "Website",
        :user => nil
      ),
      stub_model(Person,
        :name => "Name",
        :last_name => "Last Name",
        :email => "Email",
        :company => "Company",
        :job_title => "Job Title",
        :phone => "Phone",
        :website => "Website",
        :user => nil
      )
    ])
  end

  it "renders a list of people" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Last Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => "Company".to_s, :count => 2
    assert_select "tr>td", :text => "Job Title".to_s, :count => 2
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    assert_select "tr>td", :text => "Website".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end

require 'spec_helper'

describe "people/show" do
  before(:each) do
    @person = assign(:person, stub_model(Person,
      :name => "Name",
      :last_name => "Last Name",
      :email => "Email",
      :company => "Company",
      :job_title => "Job Title",
      :phone => "Phone",
      :website => "Website",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Last Name/)
    rendered.should match(/Email/)
    rendered.should match(/Company/)
    rendered.should match(/Job Title/)
    rendered.should match(/Phone/)
    rendered.should match(/Website/)
    rendered.should match(//)
  end
end

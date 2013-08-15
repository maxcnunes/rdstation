require 'spec_helper'

describe "people/new" do
  before(:each) do
    assign(:person, stub_model(Person,
      :name => "MyString",
      :last_name => "MyString",
      :email => "MyString",
      :company => "MyString",
      :job_title => "MyString",
      :phone => "MyString",
      :website => "MyString",
      :user => nil
    ).as_new_record)
  end

  it "renders new person form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", people_path, "post" do
      assert_select "input#person_name[name=?]", "person[name]"
      assert_select "input#person_last_name[name=?]", "person[last_name]"
      assert_select "input#person_email[name=?]", "person[email]"
      assert_select "input#person_company[name=?]", "person[company]"
      assert_select "input#person_job_title[name=?]", "person[job_title]"
      assert_select "input#person_phone[name=?]", "person[phone]"
      assert_select "input#person_website[name=?]", "person[website]"
      assert_select "input#person_user[name=?]", "person[user]"
    end
  end
end

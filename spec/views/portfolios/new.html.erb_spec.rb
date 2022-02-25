require 'rails_helper'

RSpec.describe "portfolios/new", type: :view do
  before(:each) do
    assign(:portfolio, Portfolio.new(
      title: "MyString",
      userID: ""
    ))
  end

  it "renders new portfolio form" do
    render

    assert_select "form[action=?][method=?]", portfolios_path, "post" do

      assert_select "input[name=?]", "portfolio[title]"

      assert_select "input[name=?]", "portfolio[userID]"
    end
  end
end

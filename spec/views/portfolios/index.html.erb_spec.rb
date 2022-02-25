require 'rails_helper'

RSpec.describe "portfolios/index", type: :view do
  before(:each) do
    assign(:portfolios, [
      Portfolio.create!(
        title: "Title",
        userID: ""
      ),
      Portfolio.create!(
        title: "Title",
        userID: ""
      )
    ])
  end

  it "renders a list of portfolios" do
    render
    assert_select "tr>td", text: "Title".to_s, count: 2
    assert_select "tr>td", text: "".to_s, count: 2
  end
end

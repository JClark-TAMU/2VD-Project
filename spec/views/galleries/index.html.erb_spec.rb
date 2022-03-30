require 'rails_helper'

RSpec.describe "galleries/index", type: :view do
  before(:each) do
    assign(:galleries, [
      Gallery.create!(
        prompt: "Prompt"
      ),
      Gallery.create!(
        prompt: "Prompt"
      )
    ])
  end

  it "renders a list of galleries" do
    render
    assert_select "tr>td", text: "Prompt".to_s, count: 2
  end
end

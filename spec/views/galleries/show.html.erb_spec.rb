require 'rails_helper'

RSpec.describe "galleries/show", type: :view do
  before(:each) do
    @gallery = assign(:gallery, Gallery.create!(
      prompt: "Prompt"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Prompt/)
  end
end

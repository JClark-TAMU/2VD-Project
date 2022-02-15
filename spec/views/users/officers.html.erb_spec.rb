require 'rails_helper'

RSpec.describe "users/officers", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      username: "Username",
      password: "Password",
      email: "Email",
      isAdmin: true,
      role: "Role",
      bio: "Bio",
      portfolioID: ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Username/)
    expect(rendered).to match(/Password/)
    expect(rendered).to match(/Email/)
    expect(rendered).to match(/true/)
    expect(rendered).to match(/Role/)
    expect(rendered).to match(/Bio/)
    expect(rendered).to match(//)
  end
end



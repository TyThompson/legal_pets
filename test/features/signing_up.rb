require 'rails_helper'

feature "Signing up", type: :feature do
  def make_user
    User.create! email: "user@example.com", password: "hunter2"
  end

  def log_in user=nil
    user ||= make_user

    visit "/"
    click_on "Login"
    within "#new_user" do
      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      click_on "Login"
    end
  end

  it "can create a user account" do
    visit "/"
    click_on "Register"

    fill_in "Email", with: "user@example.com"
    fill_in "Password", with: "hunter2"
    fill_in "Password confirmation", with: "hunter2"
    click_on "Register"

    expect(User.count).to eq 1 # ??
    expect(page).to have_content "You have signed up successfully."
  end

end

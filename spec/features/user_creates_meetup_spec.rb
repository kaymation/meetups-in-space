require 'spec_helper'

feature "User creates meetup" do
  let(:user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  scenario "user creates valid meetup" do
    sign_in_as user
    visit "/meetups/new"

    attributes = {
      "name" => "Space Meetup",
      "details" => "Frreeee32432432523525245eeedom",
      "when" => "today",
      "location" => "space"
    }

    attributes.each do |key, value|
      fill_in key, with: value
    end

    click_button "Submit"

    expect(page).to have_content(attributes["name"])
    expect(page).to have_content("When: today")
    expect(page).to have_content("Where: space")
    expect(page).to have_content("Created by #{user.username}")
  end

  scenario "User does not fill out form correctly" do
    sign_in_as user
    visit "/meetups/new"

    fill_in "name", with: "bleh bleh"

    click_button "Submit"
    expect(page).to have_content("You must specify a details, when, location")
  end
end

require 'spec_helper'

feature "user joins meetup" do
  let(:owner_user) do
    User.create(
      provider: "github",
      uid: "1",
      username: "jarlax1",
      email: "jarlax1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end
  let(:user) do
    User.create(
      provider: "github",
      uid: "2",
      username: "Bing Bong",
      email: "bb1@launchacademy.com",
      avatar_url: "https://avatars2.githubusercontent.com/u/174825?v=3&s=400"
    )
  end

  let(:meetup) {Meetup.create(name: "Space", details: "in spaaaaaaaaaaaaaaaaaaace", when: "Time is relative in space", location: "space")}
  scenario "user joins a given meetup" do
    meetup.owner = owner_user
    sign_in_as user
    visit "/meetups/#{meetup.id}"

    click_link "Join!"

    expect(page).to have_content(user.username)
    expect(page).not_to have_content("Created by #{user.username}")
  end
end

require 'spec_helper'

feature "user navigates to and views a meetup" do
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

  scenario "user clicks meetup link" do
    meetup.owner = user
    visit '/'

    click_link "Space"

    expect(page).to have_content("When: Time is relative in space ")
  end
end

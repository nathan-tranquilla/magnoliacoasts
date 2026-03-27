require "spec_helper"

links = [
  {
    origin: "/",
    dest: "/about",
    text: "About Me",
  },
  {
    origin: "/investment",
    dest: "/investment/maternity",
    text: "Maternity Packages",
  },
  {
    origin: "/investment",
    dest: "/investment/newborn",
    text: "Newborn Packages",
  },
  {
    origin: "/investment",
    dest: "/investment/milestone",
    text: "Milestone Packages",
  },
  {
    origin: "/investment",
    dest: "/investment/family",
    text: "Family Packages",
  },
  {
    origin: "/investment",
    dest: "/investment/headshot",
    text: "Headshot Packages",
  },
  {
    origin: "/investment",
    dest: "/investment/collections",
    text: "Collection Packages",
  },
  {
    origin: "/gallery/maternity",
    dest: "/investment/maternity",
    text: "View Maternity Packages",
  },
  {
    origin: "/gallery/newborn",
    dest: "/investment/newborn",
    text: "View Newborn Packages",
  },
  {
    origin: "/gallery/milestones",
    dest: "/investment/milestone",
    text: "View Milestone Packages",
  },
  {
    origin: "/gallery/cakesmash",
    dest: "/investment/milestone",
    text: "View Milestone Packages",
  },
  {
    origin: "/gallery/family",
    dest: "/investment/family",
    text: "View Family Packages",
  },
  {
    origin: "/gallery/children",
    dest: "/investment/family",
    text: "View Family Packages",
  },
  {
    origin: "/gallery/headshots",
    dest: "/investment/headshot",
    text: "View Headshot Packages",
  },
  {
    origin: "/gallery/branding",
    dest: "/investment/headshot",
    text: "View Headshot Packages",
  },
  {
    origin: "/",
    dest: "/gallery/maternity",
    text: "Maternity",
    within: "#special_moments",
  },
  {
    origin: "/",
    dest: "/gallery/newborn",
    text: "Newborn",
    within: "#special_moments",
  },
  {
    origin: "/",
    dest: "/gallery/family",
    text: "Family",
    within: "#special_moments",
  },
  {
    origin: "/",
    dest: "/gallery/cakesmash",
    text: "Cake Smashes",
    within: "#special_moments",
  },
  {
    origin: "/",
    dest: "/gallery/milestones",
    text: "Milestones",
    within: "#other_special_moments",
  },
  {
    origin: "/",
    dest: "/gallery/children",
    text: "Children",
    within: "#other_special_moments",
  },
  {
    origin: "/",
    dest: "/gallery/branding",
    text: "Branding",
    within: "#other_special_moments",
  },
  {
    origin: "/",
    dest: "/gallery/headshots",
    text: "Headshots",
    within: "#other_special_moments",
  },
]

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "cross links with #{driver}", type: :feature, driver: driver, cross_links: true do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

    links.each do |test_case|
      it "works from #{test_case[:origin]} to #{test_case[:dest]}" do
        visit test_case[:origin]
        scope = test_case[:within] ? find(test_case[:within]) : page
        scope.find("a", text: test_case[:text]).click
        expect(page.current_url).to include(test_case[:dest]), "Expected URL to include '#{test_case[:dest]}', but was #{page.current_url}"
      end
    end
  end
end
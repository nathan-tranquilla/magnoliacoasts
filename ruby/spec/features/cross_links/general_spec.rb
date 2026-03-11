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
  # Gallery → Investment cross-links
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
    origin: "/gallery/family",
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
    text: "View Headshot & Branding Packages",
  },
  # Investment → Gallery cross-links
  {
    origin: "/investment/maternity",
    dest: "/gallery/maternity",
    text: "View Maternity Gallery",
  },
  {
    origin: "/investment/newborn",
    dest: "/gallery/newborn",
    text: "View Newborn Gallery",
  },
  {
    origin: "/investment/milestone",
    dest: "/gallery/milestones",
    text: "View Milestone Gallery",
  },
  {
    origin: "/investment/family",
    dest: "/gallery/family",
    text: "View Family Gallery",
  },
  {
    origin: "/investment/headshot",
    dest: "/gallery/headshots",
    text: "View Headshot Gallery",
  }
]

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "cross links with #{driver}", type: :feature, driver: driver, cross_links: true do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

    links.each do |test_case|
      it "works from #{test_case[:origin]} to #{test_case[:dest]}" do
        visit test_case[:origin]
        find("a", text: test_case[:text]).click
        expect(page.current_url).to include(test_case[:dest]), "Expected URL to include '#{test_case[:dest]}', but was #{page.current_url}"
      end
    end 
  end
end
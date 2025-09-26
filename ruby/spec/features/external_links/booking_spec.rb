require "spec_helper"
require "support/constants"

links = [
  {
    origin: "/",
    text: "Inquire",
    external_link: Constants::INQUIRE_LINK,
    within: 'main'
  },
  {
    origin: "/",
    external_link: Constants::MATERNITY_LINK,
    text: "Maternity",
    within: "#special_moments"
  },
  {
    origin: "/",
    external_link: Constants::NEWBORN_LINK,
    text: "Newborn",
    within: "#special_moments"
  },
  {
    origin: "/",
    external_link: Constants::MILESTONES_LINK,
    text: "Milestones",
    within: "#other_special_moments"
  },
  {
    origin: "/",
    external_link: Constants::FAMILY_LINK,
    text: "Family",
    within: "#special_moments"
  },
  {
    origin: "/",
    external_link: Constants::BRANDING_LINK,
    text: "Branding",
    within: "#other_special_moments"
  },
  {
    origin: "/",
    external_link: Constants::HEADSHOTS_LINK,
    text: "Headshots",
    within: "#other_special_moments"
  },
  {
    origin: "/",
    external_link: Constants::MILESTONES_LINK,
    text: "Children",
    within: "#other_special_moments"
  },
  {
    origin: "/",
    text: "Subscribe",
    external_link: Constants::SUBSCRIBE_LINK,
    within: 'main'
  },
  {
    origin: "/about",
    text: "Book With Stephanie",
    external_link: Constants::INQUIRE_LINK,
    within: 'main'
  },
  {
    origin: "/investment/maternity",
    text: "Inquire",
    external_link: Constants::MATERNITY_LINK,
    within: 'main'
  },
  {
    origin: "/investment/newborn",
    text: "Inquire",
    external_link: Constants::NEWBORN_LINK,
    within: 'main'
  },
  {
    origin: "/investment/milestone",
    text: "Inquire",
    external_link: Constants::MILESTONES_LINK,
    within: 'main'
  },
  {
    origin: "/investment/family",
    text: "Inquire",
    external_link: Constants::FAMILY_LINK,
    within: 'main'
  },
  {
    origin: "/investment/headshot",
    text: "Inquire",
    external_link: Constants::HEADSHOTS_LINK,
    within: 'main'
  },
  {
    origin: "/investment/collections",
    text: "Inquire",
    external_link: Constants::INQUIRE_LINK,
    within: 'main'
  },
  {
    origin: "/",
    text: "Contact Us",
    external_link: Constants::INQUIRE_LINK,
    within: 'footer'
  },
  {
    origin: "/",
    text: "Subscribe",
    external_link: Constants::SUBSCRIBE_LINK,
    within: 'footer'
  },
]

titles = [
  {
    origin: "/",
    class: "facebook",
    external_link: Constants::FACEBOOK_LINK,
    within: 'footer'
  },
  {
    origin: "/",
    class: "instagram",
    external_link: Constants::INSTAGRAM_LINK,
    within: 'footer'
  },
  {
    origin: "/",
    class: "pintrest",
    external_link: Constants::PINTREST_LINK,
    within: 'footer'
  },
]

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "(#{driver}) external link", type: :feature, driver: driver, external_links: true do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

    links.each do |test_case|
      it "#{test_case[:external_link]} on page \"#{test_case[:origin]}\" is found associated with \"#{test_case[:text]}\"" do
        visit test_case[:origin]
        within(test_case[:within]) do 
          links = all("a", text: test_case[:text], visible: :all).select { |a| a[:href] == test_case[:external_link] }
          expect(links.size).to be > 0
        end 
      end
    end 

    titles.each do |test_case|
      it "has all expected links" do
        visit test_case[:origin]
        within(test_case[:within]) do 
          links = all("a", class: test_case[:class], visible: :all).select { |a| a[:href] == test_case[:external_link] }
          expect(links.size).to be > 0
        end 
      end
    end 
  end
end
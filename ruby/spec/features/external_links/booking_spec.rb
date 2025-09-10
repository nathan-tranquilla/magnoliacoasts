require "spec_helper"
require "support/constants"

links = [
  {
    origin: "/",
    text: "Inquire",
    external_link: Constants::INQUIRE_LINK,
    expected_links: 1
  },
  {
    origin: "/",
    text: "Subscribe",
    external_link: Constants::SUBSCRIBE_LINK,
    expected_links: 1
  },
  {
    origin: "/about",
    text: "Book With Stephanie",
    external_link: Constants::INQUIRE_LINK,
    expected_links: 1
  },
  {
    origin: "/investment/maternity",
    text: "Inquire",
    external_link: Constants::INQUIRE_LINK,
    expected_links: 2
  },
  {
    origin: "/investment/newborn",
    text: "Inquire",
    external_link: Constants::INQUIRE_LINK,
    expected_links: 3
  },
  {
    origin: "/investment/milestone",
    text: "Inquire",
    external_link: Constants::INQUIRE_LINK,
    expected_links: 3
  },
  {
    origin: "/investment/family",
    text: "Inquire",
    external_link: Constants::INQUIRE_LINK,
    expected_links: 4
  },
  {
    origin: "/investment/headshot",
    text: "Inquire",
    external_link: Constants::INQUIRE_LINK,
    expected_links: 4
  }
]

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "external links with #{driver}", type: :feature, driver: driver do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

    links.each do |test_case|
      it "has all expected links" do
        visit test_case[:origin]
        links = all("a", text: test_case[:text], visible: :all).select { |a| a[:href] == test_case[:external_link] }
        expect(links.size).to eq(test_case[:expected_links])
      end
    end 
  end
end
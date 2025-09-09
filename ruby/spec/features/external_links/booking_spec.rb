require "spec_helper"
require "support/constants"

links = [
  {
    origin: "/",
    text: "Inquire",
    external_link: Constants::INQUIRE_LINK
  },
  {
    origin: "/",
    text: "Subscribe",
    external_link: Constants::SUBSCRIBE_LINK
  },
  {
    origin: "/about",
    text: "Book With Stephanie",
    external_link: Constants::INQUIRE_LINK
  }
]

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "external links with #{driver}", type: :feature, driver: driver do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

    links.each do |test_case|
      it "are present on page: #{test_case[:text]}" do
        visit test_case[:origin]
        expect(page).to have_link(test_case[:text], href: test_case[:external_link])
      end
    end 
  end
end
require "spec_helper"

links = [
  {
    origin: "/",
    dest: "/about",
    text: "Get to know me",
  },
  {
    origin: "/investment",
    dest: "/investment/maternity",
    text: "Maternity Packages",
  },
  {
    origin: "/",
    dest: "/investment/maternity",
    text: "Maternity",
  },
  {
    origin: "/",
    dest: "/investment/newborn",
    text: "Newborn",
  }
]

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "cross links with #{driver}", type: :feature, driver: driver do
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
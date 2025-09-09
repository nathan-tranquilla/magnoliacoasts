require "spec_helper"

links = [
  {
    origin: "/",
    dest: "/about",
    text: "About Photographer",
  }
]


RSpec.describe "cross links with cuprite", type: :feature do
  links.each do |test_case|
    it "works from #{test_case[:origin]} to #{test_case[:dest]}" do
      visit test_case[:origin]
      within("nav") do
        find("a", text: test_case[:text]).click
      end 
      expect(page.current_url).to include(test_case[:dest]), "Expected URL to include '#{test_case[:dest]}', but was #{page.current_url}"
    end
  end 
end

RSpec.describe "cross links with cuprite_mobile", type: :feature do
  before { Capybara.current_driver = :cuprite_mobile }
  after  { Capybara.use_default_driver }
  links.each do |test_case|
    it "works from #{test_case[:origin]} to #{test_case[:dest]}" do
      visit test_case[:origin]
      within("nav") do
        find("label").click 
        find("a", text: test_case[:text]).click
      end 
      expect(page.current_url).to include(test_case[:dest]), "Expected URL to include '#{test_case[:dest]}', but was #{page.current_url}"
    end
  end 
end

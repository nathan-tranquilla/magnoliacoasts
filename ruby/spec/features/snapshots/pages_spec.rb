require "spec_helper"
require 'capybara_screenshot_diff/rspec'
Capybara::Screenshot::Diff.tolerance = 0.3


investments = [
  "/maternity",
  "/newborn",
  "/milestone",
  "/family",
  "/headshot",
  "/collections",
]

galleries = [
  "/maternity",
  "/newborn",
  "/family",
  "/cakesmash",
]

links = [
  "/",
  "/about",
  "/investment",
  *investments.map { |path| "/investment#{path}" },
  "/gallery",
  *galleries.map { |path| "/gallery#{path}" },
]

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "pages are styled correctly", type: :feature, driver: driver, snapshot: true do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

    links.each do |link|
      it "on page #{link}" do
        visit link
        sleep 1
        driver_name = driver.to_s
        filename = link == '/' ? 'home' : link.sub(/^\//, '').gsub('/', '-')
        expect(page).to match_screenshot("#{driver_name}/#{filename}.png")
      end
    end 
  end
end
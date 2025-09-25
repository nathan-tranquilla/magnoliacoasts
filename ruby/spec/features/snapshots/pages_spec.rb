require "spec_helper"
require 'capybara_screenshot_diff/rspec'
require_relative '../../support/utils'
Capybara::Screenshot::Diff.tolerance = 0.40


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
  "/headshots",
  "/branding",
  "/milestones",
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
  RSpec.describe "pages are styled correctly on #{driver}", type: :feature, driver: driver, snapshot: true do
    before { Capybara.current_driver = driver }
    after  { Capybara.use_default_driver }

    links.each do |link|
      it "on page #{link}" do
        visit link
        Utils.set_browser_date(page, 2024, 01, 01)
        sleep 1
        driver_name = driver.to_s
        filename = link == '/' ? 'home' : link.sub(/^\//, '').gsub('/', '-')
        expect(page).to match_screenshot("#{driver_name}/#{filename}.png")
      end
    end 
  end
end
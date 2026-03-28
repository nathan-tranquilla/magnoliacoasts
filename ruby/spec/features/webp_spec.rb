require "spec_helper"

GALLERY_PAGES = [
  "/gallery/maternity",
  "/gallery/newborn",
  "/gallery/milestones",
  "/gallery/cakesmash",
  "/gallery/family",
  "/gallery/children",
  "/gallery/branding",
  "/gallery/headshots",
]

RSpec.describe "gallery webp images", type: :feature, driver: :cuprite, tier2: true, webp: true do
  before { Capybara.current_driver = :cuprite }
  after  { Capybara.use_default_driver }

  GALLERY_PAGES.each do |gallery_path|
    it "has webp images on #{gallery_path}" do
      visit gallery_path
      expect(page).to have_css("img[src*='webp']"),
        "Expected at least one webp image on #{gallery_path}, but none were found"
    end
  end
end

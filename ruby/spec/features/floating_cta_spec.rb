require "spec_helper"

# Tests the FloatingCta React component (FloatingCta.res) rendered on gallery pages.
# The CTA is an <a> tag that becomes visible when the user scrolls past the h2 element.
#
# DOM structure:
#   - <a> with aria-hidden="true" and opacity-0 when h2 is in view
#   - <a> with aria-hidden="false" and opacity-100 when h2 is out of view
#   - Text content is the label + " →" (e.g. "View Maternity Packages →")

GALLERY_CTA = [
  { url: "/gallery/maternity", label: "View Maternity Packages" },
  { url: "/gallery/newborn", label: "View Newborn Packages" },
  { url: "/gallery/family", label: "View Family Packages" },
]

[:cuprite, :cuprite_mobile].each do |driver|
  RSpec.describe "Floating CTA (#{driver})", type: :feature, driver: driver, tag: :floating_cta do
    before do
      Capybara.current_driver = driver
    end
    after { Capybara.use_default_driver }

    GALLERY_CTA.each do |test_case|
      context "on #{test_case[:url]}" do
        before { visit test_case[:url] }

        it "renders the CTA link with correct text" do
          cta = find("a[aria-hidden]", visible: :all)
          expect(cta.text(:all)).to include(test_case[:label])
        end

        it "CTA is hidden when h2 is in the viewport" do
          cta = find("a[aria-hidden]", visible: :all)
          expect(cta["aria-hidden"]).to eq("true")
          expect(cta[:class]).to include("opacity-0")
        end

        it "CTA becomes visible after scrolling past h2" do
          # Pad page height so h2 can scroll fully out of viewport (lazy images keep page short)
          page.execute_script("document.body.style.paddingBottom = '3000px'")
          sleep 1 # wait for client:idle hydration

          # Scroll h2 completely above the viewport
          page.execute_script("const h2 = document.querySelector('h2'); window.scrollTo(0, h2.getBoundingClientRect().bottom + window.scrollY + 10)")
          sleep 1

          cta = find("a[aria-hidden]", visible: :all)
          expect(cta["aria-hidden"]).to eq("false")
          expect(cta[:class]).to include("opacity-100")
        end

        it "CTA hides again when scrolling back to top" do
          page.execute_script("document.body.style.paddingBottom = '3000px'")
          sleep 1

          page.execute_script("const h2 = document.querySelector('h2'); window.scrollTo(0, h2.getBoundingClientRect().bottom + window.scrollY + 10)")
          sleep 1

          # Scroll back to top
          page.execute_script("window.scrollTo(0, 0)")
          sleep 1

          cta = find("a[aria-hidden]", visible: :all)
          expect(cta["aria-hidden"]).to eq("true")
          expect(cta[:class]).to include("opacity-0")
        end

        it "CTA links to the correct investment page" do
          cta = find("a[aria-hidden]", visible: :all)
          expect(cta[:href]).to include("/investment/")
        end
      end
    end
  end
end

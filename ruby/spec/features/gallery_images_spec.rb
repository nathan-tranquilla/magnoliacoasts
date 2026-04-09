require "spec_helper"

GALLERY_IMAGES = [
  { url: "/gallery/maternity", title: "Maternity", min_images: 10 },
  { url: "/gallery/newborn", title: "Newborn", min_images: 10 },
  { url: "/gallery/milestones", title: "Milestone", min_images: 10 },
  { url: "/gallery/cakesmash", title: "Cake Smash", min_images: 10 },
  { url: "/gallery/family", title: "Family", min_images: 10 },
  { url: "/gallery/children", title: "Children", min_images: 10 },
  { url: "/gallery/branding", title: "Branding", min_images: 10 },
  { url: "/gallery/headshots", title: "Headshots", min_images: 10 },
]

RSpec.describe "Gallery images", type: :feature, tag: :gallery_images do
  GALLERY_IMAGES.each do |gallery|
    context gallery[:url] do
      before { visit gallery[:url] }

      it "renders at least #{gallery[:min_images]} gallery images" do
        images = all("img[alt^='Gallery image-']", visible: :all)
        expect(images.count).to be >= gallery[:min_images]
      end

      it "all gallery images have a webp src" do
        images = all("img[alt^='Gallery image-']", visible: :all)
        images.each do |img|
          expect(img[:src]).to include("webp"), "Expected webp src for #{img[:alt]}, got #{img[:src]}"
        end
      end
    end
  end
end

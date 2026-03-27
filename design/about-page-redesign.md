# About Page Redesign (reverted)

## Status: Reverted — ready to re-apply

## Commit to revert-the-revert
`git revert HEAD` (revert commit 6d7dc30) will re-apply the redesign.

Alternatively, cherry-pick the original squashed commit:
`git cherry-pick 350ec55`

## Changes
- Replaced Card-based grid layout with flexbox: image collage on left, text content on right
- Added drop cap styling on first paragraph (dark-green, 2.5em)
- Images displayed as collage: hero image full-width on top, two smaller images in a 2-column grid below
- Moved SectionHeader outside article element for consistent header height across gallery/investment pages
- Changed padding from `py-` to `pb-` (bottom-only) to match other page layouts
- Centered CTA button below content
- Removed unused Card component import and grid layout variables

## Origin
Cherry-picked from main-backup commits:
- a441c26 — Redesign about page layout with drop cap, image collage, and cleaner structure
- 95015fb — Fix about page header height to match gallery and investment pages

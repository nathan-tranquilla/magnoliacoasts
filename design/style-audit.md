# Style Audit — Magnolia Coasts Photography

## HIGH PRIORITY

- [ ] **1. Navigation links lack hover/active states**
  Nav links have no visual feedback — no underline, color change, or active page indicator.
  - Add `hover:text-[#392C2C]/60` and an underline or bottom border for active page
  - Consider `tracking-widest uppercase text-sm` for a more editorial feel
  - **File:** `src/components/Nav.astro`

- [ ] **2. Gallery index cards feel plain**
  Cards show an image + pink label with no interaction feedback or refinement.
  - Add subtle hover lift (`hover:-translate-y-1 hover:shadow-lg transition-all`)
  - Consider overlaying the title on the image with a semi-transparent gradient instead of the separate pink box
  - **File:** `src/components/InvestmentCard.astro`, `src/pages/gallery.astro`

- [ ] **3. Investment index cards inconsistent with gallery cards**
  Investment index cards have no pink label background, just text below images — more sparse than gallery cards.
  - Unify card styles between gallery and investment index pages
  - Both should have the same hover behavior and visual weight
  - **File:** `src/pages/investment.astro`

- [ ] **4. Investment detail cards — price/Inquire row feels cramped**
  The price and Inquire button at the bottom are squeezed together. The button is small and easy to miss.
  - Give the price + CTA section more breathing room (larger padding top)
  - Make the Inquire button full-width or at least more prominent
  - **Files:** `src/components/StandardInvestment.astro`, `src/components/CollectionsInvestment.astro`

- [ ] **5. Section spacing is uneven across the homepage**
  The gaps between hero, welcome, special moments, art in your home, testimonials, and newsletter sections vary.
  - Standardize section padding to `py-12 md:py-16` consistently
  - **File:** `src/pages/index.astro` and individual section components

---

## MEDIUM PRIORITY

- [ ] **6. Footer feels dense and utilitarian**
  The dark green footer with 3-column city lists looks functional but not elegant. Links are plain text.
  - Add more vertical padding
  - Consider a lighter divider line between sections
  - **File:** `src/components/Footer.astro`

- [ ] **7. Breadcrumbs are unstyled**
  Bare gray text, looks like an afterthought.
  - Add a subtle separator character with proper spacing
  - Match the font weight to the nav
  - **File:** `src/components/Breadcrumbs.astro`

- [ ] **8. About page — text wall**
  Long block of body text not broken up visually.
  - Add a pull quote or larger first paragraph
  - Consider a divider between sections (similar to the hero diamond divider)
  - **File:** `src/pages/about.astro`

- [ ] **9. Button color inconsistency**
  Pink buttons (primary CTA) have no border. Mint buttons (secondary) have `border border-[#8DA5A3]`. Different visual weight.
  - Add a subtle border to pink buttons (`border border-pink-active`)
  - Or remove the border from mint and rely on background color alone
  - **File:** `src/components/Button.astro`

- [ ] **10. Mobile investment cards — text is very small**
  Bullet lists at small size with minimal spacing. Feels cramped on mobile.
  - Increase mobile font size for investment details
  - Add more line height to the list items
  - **Files:** `src/components/StandardInvestment.astro`, `src/components/CollectionsInvestment.astro`

---

## LOWER PRIORITY

- [ ] **11. Gallery grid visual rhythm**
  The masonry layout aspect ratio logic (every 3rd/4th image landscape) creates some awkward combinations depending on image count.

- [ ] **12. Testimonial carousel dots are generic**
  Small gray/active-gray dots are visually disconnected from the warm palette.
  - Change active dot to `bg-pink` instead of `bg-app-active-grey`
  - Consider using the diamond symbol from the hero divider instead of circles
  - **File:** `src/components/Carousel.res`

- [ ] **13. SectionHeader uses `text-nowrap`**
  Prevents wrapping on small screens — could cause overflow with long titles like "Collections Packages".
  - Remove `text-nowrap` or add `overflow-hidden text-ellipsis` as fallback
  - **File:** `src/components/SectionHeader.astro`

- [ ] **14. Card shadow is very soft**
  `shadow-card: 0 0 10px rgba(96, 96, 96, 0.25)` is a centered glow with no offset. Professional cards typically use a subtle downward shadow.
  - Change to `0 2px 12px rgba(96, 96, 96, 0.15)` for a more natural look
  - **File:** `src/styles/global.css` (`@theme` block)

- [ ] **15. Color consolidation**
  Several one-off hex values: `#392C2C`, `#5A5A5A`, `#D7D7D7`, `#d4c5c5`, `#b8a8a8`, `#ACABAC`, `#8DA5A3`, `#C5C5C5`. Should be named theme tokens.
  - **File:** `src/styles/global.css` (`@theme` block)

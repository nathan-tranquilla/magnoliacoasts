# Style Audit — Magnolia Coasts Photography

## HIGH PRIORITY

- [x] **1. Navigation links lack hover/active states**
  Added hover color transition, underline with offset for active page, `aria-current="page"`.
  Active detection via ReScript `is_active_link` helper.
  - **Files:** `src/components/Nav.astro`, `src/utils/utils.res`

- [x] **2. Gallery index cards feel plain**
  Replaced pink button labels with gradient overlay title. Always visible on mobile, fade-in on hover for desktop.
  - **File:** `src/pages/gallery.astro`

- [x] **3. Investment index cards inconsistent with gallery cards**
  Unified with gallery cards — same overlay style. Always visible on mobile, fade-in on hover for desktop.
  - **File:** `src/components/InvestmentCard.astro`

- [x] **4. Investment detail cards — price/Inquire row feels cramped**
  Stacked price and button vertically with a top border separator. Full-width Inquire button with larger text.
  - **Files:** `src/components/StandardInvestment.astro`, `src/components/CollectionsInvestment.astro`

- [x] **5. Section spacing is uneven across the homepage**
  Standardized to `py-12 md:py-16` on Welcome, SpecialMoments, Testimonials, and Newsletter.
  - **Files:** `Welcome.astro`, `SpecialMoments.astro`, `TestimonialCarousel.astro`, `Newsletter.astro`

---

## MEDIUM PRIORITY

- [x] **6. Footer feels dense and utilitarian**
  Redesigned with zone-based layout: logo + social icons, navigation links, service areas, and copyright — separated by `border-t border-white/10` dividers. More vertical padding and elegant spacing.
  - **File:** `src/components/Footer.astro`

- [x] **7. Breadcrumbs are unstyled**
  Diamond separator (✦), site palette colors (`text-[#392C2C]/80`), WCAG AA contrast (6.3:1+ on all backgrounds). Consistent background via `mainClass` prop on `Main.astro` so breadcrumbs blend into page content.
  - **Files:** `src/components/Breadcrumbs.astro`, `src/layouts/Main.astro`, `src/pages/about.astro`, `src/pages/gallery.astro`, `src/pages/investment.astro`

- [x] **8. About page — text wall**
  Redesigned layout: drop cap on first paragraph (`::first-letter`), image collage (hero + two smaller side-by-side) in left column with text on right (desktop), cleaner spacing and rounded shadow cards.
  - **File:** `src/pages/about.astro`

- [x] **9. Button color inconsistency**
  Added `border border-[#e8a9a5]` to pink buttons for consistent visual weight with mint buttons (`border border-[#8DA5A3]`).
  - **File:** `src/components/Button.astro`

- [x] **10. Mobile investment cards — text is very small**
  Acceptable — list items already use `text-lg` (18px). No change needed.
  - **Files:** `src/components/StandardInvestment.astro`, `src/components/CollectionsInvestment.astro`

---

## LOWER PRIORITY

- [ ] **11. Gallery grid visual rhythm**
  The masonry layout aspect ratio logic (every 3rd/4th image landscape) creates some awkward combinations depending on image count.

- [x] **12. Testimonial carousel dots are generic**
  Replaced circles with rotated squares (`rotate-45 rounded-[2px]`) for a diamond/gem effect. Colors updated to warm palette: inactive `bg-light-pink`/`border-border-warm`, active `bg-pink`/`border-pink-border`.
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

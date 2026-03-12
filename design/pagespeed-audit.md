# PageSpeed Audit — Magnolia Coasts Photography

**Source:** [PageSpeed Insights](https://pagespeed.web.dev) — Mar 12 2026
**URL:** https://magnoliacoastsphotography.com/
**Lighthouse:** 12.0.1

## Scores

| Category       | Mobile | Desktop |
| -------------- | ------ | ------- |
| Performance    | 68     | 45      |
| Accessibility  | 92     | 92      |
| Best Practices | 100    | 100     |
| SEO            | 92     | 92      |

## Performance Metrics

| Metric                   | Mobile | Desktop |
| ------------------------ | ------ | ------- |
| First Contentful Paint   | 2.9 s  | 0.4 s   |
| Largest Contentful Paint | 7.1 s  | 7.2 s   |
| Total Blocking Time      | 100 ms | 230 ms  |
| Cumulative Layout Shift  | 0.051  | 0.636   |
| Speed Index              | 4.6 s  | 0.7 s   |

---

## HIGH PRIORITY

- [x] **1. CLS 0.636 on desktop — Welcome section layout shift**
  Added explicit `width`/`height` (333×500) to both mobile and desktop portrait `<img>`, `aspect-ratio: 333/500` on the desktop container, and removed `loading="lazy"` on desktop (above the fold).
  - **File:** `src/components/Welcome.astro`

- [x] **2. LCP 7.1–7.2 s — hero image delivery**
  Re-encoded all hero WebP variants with `cwebp` at proper dimensions (source was 6480×4629 stored as "1800w"). Added 1200w breakpoint. Updated `<img>` dimensions to match actual aspect ratio.
  - 1800w: 7.0 MB → 105 KB | 1200w: new, 53 KB | 900w: 30 → 35 KB | 600w: 17 → 20 KB | 414w: 19 → 10 KB
  - **Files:** `public/HeroImage.*.webp`, `src/components/HeroSection.astro`

- [x] **3. Image elements do not have explicit `width` and `height`**
  Added `width`/`height` to all raw `<img>` elements: Newsletter (367×600), SpecialMoments (300×400), Banner (2000×315). Astro `<Image>` components already handled via `layout` props.
  - **Files:** `Newsletter.astro`, `SpecialMoments.astro`, `Banner.astro`

- [x] **4. Reduce unused JavaScript — est. savings of 92 KB**
  Switched testimonial carousel from `client:load` to `client:visible` so React (195 KB) only loads when scrolled into view. Eliminates the "unused JS" flag on initial paint. Full elimination would require replacing React with Preact or vanilla JS.
  - **File:** `src/components/TestimonialCarousel.astro`

- [x] **5. Avoid enormous network payloads — total size 8,522 KiB (desktop)**
  Resolved by item 2 — hero image re-encoding reduced payload by ~6,900 KiB.

---

## MEDIUM PRIORITY

- [x] **4. Image compression can be improved**
  Added `format: "webp"` and `quality: "high"` to Astro image config. All processed images now serve as optimized WebPs. Also resized SpecialMoments images to 600px width (from full resolution) for proper 2x retina sizing.
  - **Files:** `astro.config.mjs`, `src/components/SpecialMoments.astro`

- [x] **5. Contrast ratio — background/foreground colors insufficient**
  Improved contrast on low-opacity text elements:
  - Footer "Service Areas" header: `text-white/50` → `text-white/75`
  - Footer copyright: `text-white/40` → `text-white/60`
  - ArtInYourHome overlay: `bg-pink/50` → `bg-dark-green/70` (white text on dark background)
  - **Files:** `Footer.astro`, `ArtInYourHome.astro`

- [x] **6. Touch targets too small or too close together**
  Added `min-h-[48px]` to Button component to ensure all buttons meet the 48px minimum touch target size.
  - **File:** `Button.astro`

---

## LOWER PRIORITY

- [ ] **7. Avoid long main-thread tasks — 2 long tasks found**
  - **Action:** Profile with DevTools to identify the tasks. May be related to JS bundle size (item 3).

- [ ] **8. robots.txt is not valid — 1 error found**
  SEO audit flagged a robots.txt parsing error. Managed by Cloudflare — fix in Cloudflare dashboard.

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

- [ ] **3. Image elements do not have explicit `width` and `height`**
  Missing dimensions prevent the browser from reserving layout space, contributing to CLS and slower rendering.
  - **Action:** Add explicit `width` and `height` to all `<Image>` components that lack them.

- [ ] **4. Reduce unused JavaScript — est. savings of 92 KB**
  - **Action:** Audit JS bundles. Check for unused client-side scripts or libraries being shipped unnecessarily.

- [ ] **5. Avoid enormous network payloads — total size 8,522 KiB (desktop)**
  Dominated by the hero image. Fixing item 2 should largely resolve this.
  - **Action:** Address after hero image optimization.

---

## MEDIUM PRIORITY

- [ ] **4. Image compression can be improved**
  Several images could benefit from better compression:
  - `StephaniePortrait`: 14.8 KB → 11.0 KB (est. savings 3.8 KB)
  - `Newsletter` image: 19.2 KB → 8.5 KB (compression factor)
  - `childrenInSwing`: 17.0 KB → 6.7 KB (compression factor)
  - `familyByRoad` (gallery card): 24.0 KB → 4.4 KB (compression factor)
  - **Action:** Re-export source images at tighter quality or let Astro Image handle quality settings.

- [ ] **5. Contrast ratio — background/foreground colors insufficient**
  Accessibility audit flagged insufficient contrast on some text elements.
  - **Action:** Identify affected elements and adjust colors to meet WCAG AA (4.5:1 for normal text, 3:1 for large text).

- [ ] **6. Touch targets too small or too close together**
  The "About Me" button/link area in the hero section has failing touch targets:
  - `<button class="cursor-pointer transition-all hover:scale-102 focus:scale-102 hover:shadow...">`
  - `<a href="/about" class="flex h-full w-full items-center justify-center">`
  - **Action:** Ensure touch targets are at least 48×48 px with adequate spacing.

---

## LOWER PRIORITY

- [ ] **7. Avoid long main-thread tasks — 2 long tasks found**
  - **Action:** Profile with DevTools to identify the tasks. May be related to JS bundle size (item 3).

- [ ] **8. robots.txt is not valid — 1 error found**
  SEO audit flagged a robots.txt parsing error.
  - **Action:** Validate and fix `robots.txt` (or `public/robots.txt`).

# React → Preact Migration — Magnolia Coasts

## Goal

Replace React 19 (`react` + `react-dom`, ~130 KB minified) with Preact + compat (~10 KB) across the Astro site. Because `@astrojs/preact` ships a compatibility layer that aliases all `react`/`react-dom` imports to Preact equivalents at the Vite build level, **no ReScript source files need to change**. Every `.res` component compiled by `@rescript/react` emits standard React API calls — Preact compat maps them transparently.

---

## Current Architecture

- 3 ReScript React components using `@react.component`, `React.useState`, `React.useEffect`, etc.:
  - `src/components/Carousel.res` — generic carousel with DOM manipulation via `Webapi.Dom`
  - `src/components/FloatingCta.res` — floating CTA button using `IntersectionObserver`
  - `src/components/TestimonialCarouselReact.res` — testimonial carousel with `React.Children`
- 4 ReScript utility modules (no React imports, SSR-only):
  - `src/utils/bannerUtils.res`, `src/utils/utils.res`, `src/utils/breadcrumbs.res`, `src/layouts/InvestmentPackage.res`
- Astro integration: `astro.config.mjs` uses `react()` from `@astrojs/react`
- 2 hydrated islands: `<FloatingCta client:idle>` in `Gallery.astro`, `<Carousel client:load>` in `TestimonialCarousel.astro`
- No esbuild side-builds or standalone JS bundles

## Target Architecture

Identical to current, except:

- `@astrojs/react` → `@astrojs/preact` (with `compat: true`)
- React 19 packages removed from the bundle (Preact compat satisfies `@rescript/react` at runtime)

---

## Migration Steps

### 1. Install Preact, remove the React Astro integration

```bash
npm install preact @astrojs/preact
npm uninstall @astrojs/react
```

Keep `react`, `react-dom`, `@types/react`, and `@types/react-dom` in `package.json` for now — `@rescript/react` declares them as peer dependencies. They can be removed once it is verified that Preact compat satisfies all runtime calls.

### 2. Update `astro.config.mjs`

```diff
-import react from '@astrojs/react'
+import preact from '@astrojs/preact'

 integrations: [
-  sitemap(), react()
+  sitemap(), preact({ compat: true })
 ],
```

No other config changes are needed — `build.inlineStylesheets`, `outDir`, `image`, and `markdown` settings are unaffected.

### 3. Verify Astro pages using React islands

All Astro pages import compiled `.res.mjs` modules and render them with `client:load` or `client:idle` directives. With `preact({ compat: true })`, Astro's renderer automatically treats these as Preact islands — no `.astro` page changes are required.

Spot-check these pages after build:

- **Gallery pages** — `FloatingCta` via `client:idle` (IntersectionObserver-based visibility toggle)
- **TestimonialCarousel** — `Carousel` via `client:load` (DOM class manipulation, navigation dots)
- **Home / landing pages** — ensure no hydration errors in browser console

### 4. Run build and verify

```bash
npm run build           # full Astro build to docs/
npx astro preview       # local preview of built site
rake lighthouse         # Lighthouse CI checks
```

Since there are no unit or E2E tests in this repo, manual verification of the two hydrated islands is the primary validation step.

---

## What Does NOT Change

| Area | Reason |
|------|--------|
| `src/components/*.res` source files | `@rescript/react` output is React-API-compatible; Preact compat maps it |
| `src/utils/*.res` utility modules | No React imports — pure functions used in SSR only |
| `rescript.json` | `@rescript/react` dependency stays; JSX v4 automatic mode works with Preact compat |
| All `.astro` pages and layouts | Astro renderer swap is transparent to page authors |
| `@astrojs/cloudflare` adapter | Unaffected by frontend framework swap |
| Tailwind CSS v4 / `global.css` | CSS pipeline is independent |
| `docs/` build output | Same output directory, same static files |

---

## Risk Areas

| Risk | Mitigation |
|------|------------|
| `React.Children.toArray` in TestimonialCarouselReact.res | Preact compat supports `Children` API — verify carousel renders all slides |
| `Webapi.Dom` direct DOM manipulation in Carousel.res | Browser API, not React API — no risk from framework swap |
| `IntersectionObserver` in FloatingCta.res | Browser API — unaffected |
| `@rescript/react` peer dep on `react` | Keep `react` package installed until verified; Preact compat satisfies at runtime |

---

## Expected Benefit

Replacing React 19 with Preact compat removes ~120 KB of minified JavaScript from every page that hydrates a React island (Gallery pages, testimonials section). Since `astro.config.mjs` already inlines all CSS, the React runtime is the largest JS payload on these pages. Preact compat is a drop-in replacement with full hooks and event support, so no behavioral changes are expected.

---

## Reference

- Migration template: `../nathantranquilla.me/design/` (findthatline repo)
- Preact compat docs: https://preactjs.com/guide/v10/switching-to-preact/
- `@astrojs/preact` docs: https://docs.astro.build/en/guides/integrations-guide/preact/

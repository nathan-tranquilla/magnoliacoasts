# SEO Analysis — Magnolia Coasts Photography

**Date:** 2026-03-11
**Scope:** 19 HTML pages in `docs/` build output

---

## Semantic HTML

### Passing

- All pages have `<header>`, `<nav>`, `<main>`, `<footer>` landmarks
- `lang="en"` on all pages
- 100% alt text coverage (367+ images)
- Canonical URLs, OG tags, and Twitter cards present on all pages
- Responsive images with `srcset`
- Font preloading for Cormorant Garamond and Dancing Script

### Issues

| Issue | Severity | Pages |
|-------|----------|-------|
| Homepage missing `<h1>` | High | `/` |
| No `<section>` tags anywhere | High | All 19 |
| No `<figure>` / `<figcaption>` on images | High | All gallery & investment pages |
| Minimal `<article>` usage (only `/about`) | Medium | 17 pages |

---

## LD+JSON Structured Data

### Present

| Schema Type | Pages |
|-------------|-------|
| LocalBusiness | All 19 |
| BreadcrumbList | 17 (missing from homepage) |

### LocalBusiness Issues

- `image` points to `favicon.png` — should be a real business photo
- Missing `email` (exists in meta tags but not in schema)
- Missing `streetAddress` in PostalAddress (only region, postal code, country)
- Missing `description` property

### Missing Schema Types

| Schema Type | Where | Why |
|-------------|-------|-----|
| WebSite | Homepage | Site-level name, URL, search action |
| ImageGallery + ImageObject | `/gallery/*` pages | 367+ photos with no image schema |
| Service + Offer | `/investment/*` pages | Packages with pricing not structured |
| WebPage | All pages | Page-level datePublished, dateModified |
| BreadcrumbList | Homepage | Missing only from homepage |
| Review / AggregateRating | Homepage or `/about` | Testimonials on site but not in schema |

---

## Checklist

### Semantic HTML

- [ ] Add `<h1>` to homepage
- [x] Add `<section>` tags to all pages
- [x] Wrap gallery images in `<figure>` / `<figcaption>`
- [x] Add `<article>` tags where appropriate (investment pages)

### LD+JSON — Fix Existing

- [x] LocalBusiness: change `image` from favicon to real business photo
- [x] LocalBusiness: add `email`
- [ ] LocalBusiness: add `streetAddress`
- [x] LocalBusiness: add `description`
- [x] Add BreadcrumbList to homepage

### LD+JSON — Add Missing Types

- [x] Add WebSite schema to homepage
- [x] Add ImageGallery / ImageObject schemas to gallery pages
- [x] Add Service / Offer schemas to investment pages
- [x] Add WebPage schema to all pages
- [x] Add Review / AggregateRating schema for testimonials

---

## Page Inventory

| Page | H1 | LD+JSON Types | Images | Notes |
|------|----|---------------|--------|-------|
| `/` | No | LocalBusiness | — | Missing H1, BreadcrumbList |
| `/about` | Yes | LocalBusiness, BreadcrumbList | — | Only page with `<article>` |
| `/gallery` | Yes | LocalBusiness, BreadcrumbList | grid | Index page |
| `/gallery/branding` | Yes | LocalBusiness, BreadcrumbList | 22 | No figure/section |
| `/gallery/cakesmash` | Yes | LocalBusiness, BreadcrumbList | 26 | No figure/section |
| `/gallery/children` | Yes | LocalBusiness, BreadcrumbList | 26 | No figure/section |
| `/gallery/family` | Yes | LocalBusiness, BreadcrumbList | 26 | No figure/section |
| `/gallery/headshots` | Yes | LocalBusiness, BreadcrumbList | 24 | No figure/section |
| `/gallery/maternity` | Yes | LocalBusiness, BreadcrumbList | 26 | No figure/section |
| `/gallery/milestones` | Yes | LocalBusiness, BreadcrumbList | 22 | No figure/section |
| `/gallery/newborn` | Yes | LocalBusiness, BreadcrumbList | 28 | No figure/section |
| `/investment` | Yes | LocalBusiness, BreadcrumbList | 12 | Index page |
| `/investment/collections` | Yes | LocalBusiness, BreadcrumbList | 20 | No Service schema |
| `/investment/family` | Yes | LocalBusiness, BreadcrumbList | 10 | No Service schema |
| `/investment/headshot` | Yes | LocalBusiness, BreadcrumbList | 10 | No Service schema |
| `/investment/maternity` | Yes | LocalBusiness, BreadcrumbList | 8 | No Service schema |
| `/investment/milestone` | Yes | LocalBusiness, BreadcrumbList | 9 | No Service schema |
| `/investment/newborn` | Yes | LocalBusiness, BreadcrumbList | 9 | No Service schema |

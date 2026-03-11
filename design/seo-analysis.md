# SEO Analysis — Magnolia Coasts Photography

**Date:** 2026-03-11
**Scope:** 19 HTML pages in `docs/` build output
**Primary Location:** Mississauga, Ontario

---

## Semantic HTML

### Passing

- All pages have `<header>`, `<nav>`, `<main>`, `<footer>` landmarks
- `lang="en"` on all pages
- 100% alt text coverage (367+ images)
- Canonical URLs, OG tags, and Twitter cards present on all pages
- Responsive images with `srcset`
- Font preloading for Cormorant Garamond and Dancing Script
- `<section>` tags with `aria-label` on all pages
- Gallery images wrapped in `<figure>` / `<figcaption>`
- Investment packages wrapped in `<article>` tags

### Remaining Issues

| Issue | Severity | Pages |
|-------|----------|-------|
| Homepage missing `<h1>` | High | `/` |

---

## LD+JSON Structured Data

### Current Coverage

| Schema Type | Pages |
|-------------|-------|
| LocalBusiness | All 19 |
| BreadcrumbList | All 19 (including homepage) |
| WebPage | All 19 |
| WebSite | Homepage |
| Review / AggregateRating | Homepage |
| ImageGallery / ImageObject | 8 gallery pages |
| Service / Offer | 6 investment pages |

### LocalBusiness Details

- `addressLocality`: Mississauga
- `addressRegion`: Ontario
- `postalCode`: L4W 2G8
- `image`: HeroImage.900w.webp
- `email`: info@magnoliacoastsphotography.com
- `description`: present
- `areaServed`: Mississauga, Toronto, Oakville, Brampton, Caledon, Barrie, Scarborough, Oshawa, Whitby

---

## Checklist

### Semantic HTML

- [ ] Add `<h1>` to homepage
- [x] Add `<section>` tags with `aria-label` to all pages
- [x] Wrap gallery images in `<figure>` / `<figcaption>`
- [x] Add `<article>` tags where appropriate (investment pages)

### LD+JSON — Fix Existing

- [x] LocalBusiness: change `image` from favicon to real business photo
- [x] LocalBusiness: add `email`
- [ ] LocalBusiness: add `streetAddress`
- [x] LocalBusiness: add `addressLocality` (Mississauga)
- [x] LocalBusiness: add `description`
- [x] Add BreadcrumbList to homepage

### LD+JSON — Add Missing Types

- [x] Add WebSite schema to homepage
- [x] Add ImageGallery / ImageObject schemas to gallery pages
- [x] Add Service / Offer schemas to investment pages
- [x] Add WebPage schema to all pages
- [x] Add Review / AggregateRating schema for testimonials

### Location & Metadata

- [x] Primary location set to Mississauga across all page titles
- [x] Meta descriptions reference Mississauga
- [x] OG tags reference Mississauga
- [x] Keywords prioritize Mississauga, Toronto as secondary
- [x] Service schema `areaServed` set to Mississauga, Ontario
- [x] Twitter card description lists Mississauga first

---

## Page Inventory

| Page | H1 | LD+JSON Types | Notes |
|------|----|---------------|-------|
| `/` | No | LocalBusiness, BreadcrumbList, WebPage, WebSite, Review | Missing H1 |
| `/about` | Yes | LocalBusiness, BreadcrumbList, WebPage | Has `<article>` |
| `/gallery` | Yes | LocalBusiness, BreadcrumbList, WebPage | Index page |
| `/gallery/branding` | Yes | LocalBusiness, BreadcrumbList, WebPage, ImageGallery | `<figure>` wrapped |
| `/gallery/cakesmash` | Yes | LocalBusiness, BreadcrumbList, WebPage, ImageGallery | `<figure>` wrapped |
| `/gallery/children` | Yes | LocalBusiness, BreadcrumbList, WebPage, ImageGallery | `<figure>` wrapped |
| `/gallery/family` | Yes | LocalBusiness, BreadcrumbList, WebPage, ImageGallery | `<figure>` wrapped |
| `/gallery/headshots` | Yes | LocalBusiness, BreadcrumbList, WebPage, ImageGallery | `<figure>` wrapped |
| `/gallery/maternity` | Yes | LocalBusiness, BreadcrumbList, WebPage, ImageGallery | `<figure>` wrapped |
| `/gallery/milestones` | Yes | LocalBusiness, BreadcrumbList, WebPage, ImageGallery | `<figure>` wrapped |
| `/gallery/newborn` | Yes | LocalBusiness, BreadcrumbList, WebPage, ImageGallery | `<figure>` wrapped |
| `/investment` | Yes | LocalBusiness, BreadcrumbList, WebPage | Index page |
| `/investment/collections` | Yes | LocalBusiness, BreadcrumbList, WebPage, Service | `<article>` wrapped |
| `/investment/family` | Yes | LocalBusiness, BreadcrumbList, WebPage, Service | `<article>` wrapped |
| `/investment/headshot` | Yes | LocalBusiness, BreadcrumbList, WebPage, Service | `<article>` wrapped |
| `/investment/maternity` | Yes | LocalBusiness, BreadcrumbList, WebPage, Service | `<article>` wrapped |
| `/investment/milestone` | Yes | LocalBusiness, BreadcrumbList, WebPage, Service | `<article>` wrapped |
| `/investment/newborn` | Yes | LocalBusiness, BreadcrumbList, WebPage, Service | `<article>` wrapped |

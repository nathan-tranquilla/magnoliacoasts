# SEO Analysis — Magnolia Coasts Photography

**Date:** 2026-03-11
**Scope:** 19 HTML pages in `docs/` build output
**Primary Location:** Mississauga, Ontario

---

## Completed Work

### Semantic HTML

- [x] All pages have `<header>`, `<nav>`, `<main>`, `<footer>` landmarks
- [x] `lang="en"` on all pages
- [x] 100% alt text coverage (367+ images)
- [x] Canonical URLs, OG tags, and Twitter cards present on all pages
- [x] Responsive images with `srcset`
- [x] Font preloading for Cormorant Garamond and Dancing Script
- [x] `<section>` tags with `aria-label` on all pages
- [x] Gallery images wrapped in `<figure>` / `<figcaption>`
- [x] Investment packages wrapped in `<article>` tags

### LD+JSON Structured Data

- [x] LocalBusiness on all 19 pages (with image, email, description, addressLocality)
- [x] BreadcrumbList on all 19 pages (including homepage)
- [x] WebPage on all 19 pages
- [x] WebSite on homepage
- [x] Review / AggregateRating on homepage
- [x] ImageGallery / ImageObject on 8 gallery pages
- [x] Service / Offer on 6 investment pages

### Location & Metadata

- [x] Primary location set to Mississauga across all page titles
- [x] Meta descriptions reference Mississauga
- [x] OG tags reference Mississauga
- [x] Keywords prioritize Mississauga, Toronto as secondary
- [x] Service schema `areaServed` set to Mississauga, Ontario
- [x] Twitter card description lists Mississauga first

---

## Remaining Checklist

### Technical SEO

- [x] Audit `robots.txt` — exists, allows all crawlers, links to sitemap
- [ ] Add custom 404 page
- [ ] Audit for redirect chains / broken links
- [ ] Audit render-blocking resources (CSS/JS)
- [ ] Measure Core Web Vitals (LCP, CLS, INP) via PageSpeed Insights
- [ ] Verify CLS mitigation — explicit width/height on all images to prevent layout shifts
- [ ] Verify TTFB performance (static site on Cloudflare Pages — likely good)

### On-Page SEO

- [ ] Add `<h1>` to homepage
- [x] Unique meta descriptions per page (all 18 pages have unique descriptions)
- [x] Unique OG and Twitter descriptions per page (match meta description)
- [ ] Audit heading hierarchy (H1→H2→H3) for proper nesting on all pages
- [ ] Add per-page keyword targeting (currently same keywords meta on all pages)
- [ ] Improve image filenames — currently generic (`01.jpg`, `02.jpg`), should be descriptive (e.g., `newborn-baby-sleeping.jpg`)
- [ ] Add contextual internal cross-links between related pages (e.g., gallery→investment)
- [ ] Add more descriptive text content on gallery pages (currently image-only)
- [ ] Add more descriptive text content on investment pages (currently mostly pricing)

### Structured Data — Additional

- [ ] LocalBusiness: add `streetAddress`
- [ ] Add FAQPage schema (if FAQ content is created)
- [ ] Add Person schema for photographer on `/about`

### Accessibility (SEO-adjacent)

- [ ] Add skip-to-content link
- [ ] Audit color contrast ratios
- [ ] Full keyboard navigation audit (beyond carousel)

### Off-Page / External

- [ ] Verify Google Business Profile matches LocalBusiness data (NAP consistency)
- [ ] Verify directory listings (Yelp, etc.) match NAP
- [ ] Audit backlink profile

### Content Strategy

- [ ] Consider adding a blog for fresh content signals
- [ ] Consider location-specific landing pages for secondary markets (Toronto, Oakville, Brampton)
- [ ] Add more service description copy beyond pricing

---

## LocalBusiness Details

- `addressLocality`: Mississauga
- `addressRegion`: Ontario
- `postalCode`: L4W 2G8
- `image`: HeroImage.900w.webp
- `email`: info@magnoliacoastsphotography.com
- `description`: present
- `areaServed`: Mississauga, Toronto, Oakville, Brampton, Caledon, Barrie, Scarborough, Oshawa, Whitby

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

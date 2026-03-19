# Special Moments Funnel Redesign

## Problem

The Special Moments section on the homepage links directly to external booking URLs
(book.usesession.com), bypassing the gallery and investment pages entirely. Users are
asked to buy before they've seen the portfolio or pricing. There is no funnel.

### Current Flow

```
Homepage "Special Moments" cards
    | clicks card (e.g. "Maternity")
    v
book.usesession.com (external booking form)
```

- User leaves the site immediately
- No portfolio context — they haven't seen the photographer's work
- No pricing context — they don't know what packages cost
- No engagement — zero page views beyond the homepage

## Proposed Design

### 3-Step Funnel: Discover → Desire → Decide

```
Homepage "Special Moments" cards
    | internal link to /gallery/{type}
    v
Gallery page (browse photos, build desire)
    | floating CTA + existing inline CTA
    v
Investment page (see pricing, compare packages)
    | "Inquire" button
    v
book.usesession.com (external booking)
```

| Step | Page | User Intent | CTA |
|------|------|-------------|-----|
| 1. Discover | Homepage Special Moments | "What type of session?" | Card links to gallery |
| 2. Desire | Gallery page | "Is their work good?" | Floating button to investment |
| 3. Decide | Investment page | "What does it cost?" | Inquire button to booking |

### Change 1: Special Moments cards link to galleries

Update SpecialMoments.astro to link to internal gallery pages instead of external
booking URLs.

| Card | Current Link | New Link |
|------|-------------|----------|
| Maternity | book.usesession.com/t/m-PqP2slk | /gallery/maternity |
| Newborn | book.usesession.com/t/jzCdVHVNT | /gallery/newborn |
| Family | book.usesession.com/t/qSKGXDFg9 | /gallery/family |
| Cake Smashes | book.usesession.com/t/v0bCgBueC | /gallery/cakesmash |
| Milestones | book.usesession.com/t/aOqs7teEf | /gallery/milestones |
| Children | book.usesession.com/t/T_j3GdwJze | /gallery/children |
| Branding | book.usesession.com/t/zK_v5yOEo | /gallery/branding |
| Headshots | book.usesession.com/t/MuL13nQbW | /gallery/headshots |

Also remove `target="_blank" rel="noopener"` since these become internal links.

### Change 2: Floating CTA button on gallery pages

Add a sticky button on each gallery page that stays visible as the user scrolls
through photos, linking to the corresponding investment page.

**Behavior:**
- Appears after scrolling past the intro/header section
- Stays fixed at bottom-right (mobile) or bottom-center (desktop)
- Links to the corresponding `/investment/{type}` page

**Style:**
- Dark-green background, white text (matches brand)
- Rounded corners, subtle shadow
- Text: "View Packages" or "View {Type} Packages"
- Smooth fade-in on scroll

**Layout sketch:**

```
+-----------------------------------+
|  Gallery: Family                  |
|  +-----------------------------+  |
|  | Intro text + inline CTA    |  |
|  +-----------------------------+  |
|                                   |
|  +-------+ +-------+ +-------+   |
|  |  img  | |  img  | |  img  |   |
|  +-------+ +-------+ +-------+   |
|  +-------+ +-------+             |
|  |  img  | |  img  |             |
|  +-------+ +-------+             |
|                                   |
|              +------------------+ |
|              | View Packages >  | |  <- floating button
|              +------------------+ |
+-----------------------------------+
```

**Implementation notes:**
- Use Intersection Observer on the intro section to toggle visibility
- CSS: `position: fixed; bottom: 1.5rem; right: 1.5rem` (mobile),
  centered on desktop
- z-index above gallery images but below any modal/nav overlays
- Add to Gallery.astro layout so it applies to all gallery pages
- Investment URL mapping already exists in InvestmentPackage.res (`getPackageTuple`)

### Change 3: No changes to investment pages

Investment pages already have:
- Package details and pricing
- "Inquire" buttons linking to book.usesession.com
- CTAs linking back to the gallery for cross-navigation

No modifications needed.

## Impact

- **More page views**: Users visit 2-3 pages instead of bouncing off-site
- **Higher conversion quality**: Users who reach booking have seen the portfolio
  and pricing — they're more informed and committed
- **Better analytics**: Can track the funnel (gallery views → investment views →
  booking clicks) in Google Analytics
- **SEO benefit**: Lower bounce rate, higher time-on-site, more internal linking

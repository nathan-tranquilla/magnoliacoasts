# main-backup Feature Inventory

Commits in `main-backup` not yet in `main`, organized by feature area.
Cherry-picked items are marked with ✅.

---

## 1. SEO & Metadata
| Commit | Description | Status |
|--------|-------------|--------|
| `af3f439` | Improve SEO with structured data, semantic HTML, and ReScript helpers | |
| `6bc67aa` | Update primary location from Toronto to Mississauga across all metadata | |
| `e5b8637` | Update SEO analysis doc to reflect completed improvements | |
| `290dd98` | Add unique meta descriptions per page with e2e tests | |
| `97186da` | Fix heading hierarchy: use semantic h2 tags instead of p/div | |
| `f401672` | Add per-page keyword targeting and fix headshot nav test | |
| `e4c3b46` | Rename 152 gallery images with descriptive SEO filenames and fix carousel test | |
| `7b1adcd` | Improve sibling nav SEO: fix duplicate ids, add aria-labels and sr-only text | |
| `3fb9459` | Cross links | |
| `ea158b4` | Cross links | |
| `b114ed6` | Mark cross-links and descriptive text SEO items as complete | |
| `169ed3b` | Add homepage h1/h2 to hero section and descriptive intro text on gallery/investment pages | |
| `29e2893` | Merge PR #10 — seo/hero-h1-and-intro-text | |

## 2. Performance & PageSpeed
| Commit | Description | Status |
|--------|-------------|--------|
| `34f63f9` | Add PageSpeed audit document with mobile and desktop findings | |
| `0e4a8bc` | Fix CLS 0.636 on desktop by reserving space for Welcome portrait image | |
| `235209b` | Mark CLS fix as done in pagespeed audit doc | |
| `eac9f72` | Re-encode hero images at proper dimensions (7 MB → 105 KB for 1800w) | |
| `e9ce4b8` | Add explicit width/height to all raw img elements missing dimensions | |
| `70cd893` | Defer carousel JS loading with client:visible and mark item 5 done | |
| `ad1ab8f` | Update pagespeed audit: mark items 4 and 5 done, note robots.txt is Cloudflare-managed | |
| `f841c9d` | Enable WebP format and high quality for Astro image processing | |
| `4591d6d` | Resize SpecialMoments images to 600px width for proper display size | |
| `0adf24c` | Defer Google Analytics loading until browser is idle | |
| `7db8c00` | Optimize font delivery and image responsiveness for performance | |
| `f02edd1` | Limit hero image height to above-the-fold on desktop | |

## 3. Font Optimization
| Commit | Description | Status |
|--------|-------------|--------|
| `e5261ad` | Replace Dancing Script with native cursive font | |
| `0fde52e` | Subset fonts to Latin-only and reduce preloads for performance | |
| `af6193a` | Subset remaining fonts and use font-display optional for below-the-fold | |
| `6f61b53` | Add font subsetting documentation | |

## 4. Lighthouse CI
| Commit | Description | Status |
|--------|-------------|--------|
| `ddc043a` | Add Lighthouse CI for automated performance and accessibility audits | ✅ cherry-picked |
| `068eabe` | Lower score for now | ✅ cherry-picked |
| `8c2981d` | Raise Lighthouse performance threshold to 0.87 | ✅ cherry-picked |

## 5. Style Audit & Visual Polish
| Commit | Description | Status |
|--------|-------------|--------|
| `1e9bb22` | Add style audit checklist for visual polish improvements | |
| `3736a2a` | Update card shadow to natural downward offset and mark style audit items 14-15 done | |
| `aa504a8` | Consolidate inline hex colors into named theme tokens | |
| `4bcabd2` | Add border to pink buttons for consistent visual weight with mint buttons | |
| `29a469a` | Standardize homepage section spacing to py-12 md:py-16 | |
| `2a9f3d4` | Reduce mobile section spacing and add white background to hero mobile text | |
| `36473ce` | Add staggered card entrance animation to gallery and investment index pages | |
| `e5a7ce6` | Format code | |

## 6. Hero Section Redesign
| Commit | Description | Status |
|--------|-------------|--------|
| `74da861` | Polish hero overlay with notch corners, glassmorphism, and refined typography | |
| `cc8b2fb` | Refine hero overlay with notch corners, diamond divider, and polished typography | |
| `07f133b` | Remove corner-shape property from hero overlay | |
| `62af4d8` | Add drop shadow to desktop hero Inquire button | |
| `b7d8744` | Improve mobile hero image sharpness with srcset width descriptors and sizes | |
| `94eeaf9` | Merge PR #14 — improve mobile hero image sharpness | |

## 7. Navigation & Buttons
| Commit | Description | Status |
|--------|-------------|--------|
| `ba93688` | Add nav hover/active states with ReScript helper | |
| `02168a0` | Replace text arrow buttons with SVG chevrons and unified styling | |
| `691ef79` | Replace chevron arrows with long-arrow style SVG | |
| `a582937` | Style breadcrumbs with WCAG AA contrast and consistent backgrounds | |

## 8. Card & Overlay Redesign
| Commit | Description | Status |
|--------|-------------|--------|
| `7ee3dbe` | Replace gallery and investment card labels with hover overlay titles | |
| `2d58be6` | Show card overlay titles always on mobile, fade-in on desktop hover | |
| `9f1c8cb` | Restyle special moments cards with full-image overlay pattern | |
| `21b9737` | Fix gallery grid last-row gaps and allow SectionHeader text wrapping | |

## 9. Investment Page Layout
| Commit | Description | Status |
|--------|-------------|--------|
| `f4dd5cf` | Stack investment cards vertically on mobile, 3-column grid on desktop | |
| `953f7dc` | Improve investment detail card price/CTA layout | |
| `cfb1214` | Use semantic article element for investment cards instead of div wrapper | |

## 10. Homepage Section Redesigns
| Commit | Description | Status |
|--------|-------------|--------|
| `e236cf4` | Redesign welcome section with frosted panel and float layout on mobile | |
| `4fdae15` | Redesign newsletter section as full-image banner with overlay CTA | |
| `2b2eba5` | Redesign footer with zone-based layout and dividers | |
| `ec04d8f` | Reorder homepage sections for better conversion flow | |
| `41691b9` | Merge PR #12 — update homepage section order | |

## 11. Testimonial Carousel Refactor
| Commit | Description | Status |
|--------|-------------|--------|
| `f7ba15c` | Refactor testimonial carousel to render data directly instead of via slots | |
| `08b566f` | Simplify carousel test now that slots are removed | |
| `3c2dc0e` | Polish testimonial carousel: flush image, tighter mobile layout, closer controls | |
| `a950ce1` | Restyle carousel dots as diamond shapes with warm palette colors | |

## 12. About Page Redesign
| Commit | Description | Status |
|--------|-------------|--------|
| `a441c26` | Redesign about page layout with drop cap, image collage, and cleaner structure | ✅ cherry-picked then reverted |
| `95015fb` | Fix about page header height to match gallery and investment pages | ✅ cherry-picked then reverted |

## 13. Accessibility
| Commit | Description | Status |
|--------|-------------|--------|
| `eaa594b` | Fix contrast ratio and touch target accessibility issues | |

## 14. CI & Test Infrastructure
| Commit | Description | Status |
|--------|-------------|--------|
| `59ae550` | Add unit-test and tier1 CI stages before deploy | ✅ cherry-picked |
| `96a0ed4` | Wait for dev server before running tests and add gh to Flox env | ✅ cherry-picked |
| `a530c06` | Add 5-second delay after dev server port check to prevent flaky first test | ✅ cherry-picked |
| `f9dcda0` | Update CI actions for Node.js 24 compatibility | ⏭️ skipped (version bumps already in 59ae550, lighthouse job separate) |
| `5148a2e` | Initial plan (homepage section order) | ⏭️ copilot plan doc, not CI |
| `ae59321` | Initial plan (hero image sharpness) | ⏭️ copilot plan doc, not CI |

## 15. Test Fixes
| Commit | Description | Status |
|--------|-------------|--------|
| `03a38ff` | Disable flaky carousel test (hydration timing issue) | |
| `1e397e2` | Fix carousel test ObsoleteNode error from React hydration | |
| `dd5d65c` | Fix carousel test to check opacity-0 class instead of Capybara visibility | |

## 16. Bug Fixes
| Commit | Description | Status |
|--------|-------------|--------|
| `6067c88` | Fix broken /contact link on 404 page | |

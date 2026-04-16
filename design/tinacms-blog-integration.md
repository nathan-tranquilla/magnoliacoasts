# TinaCMS Blog Integration -- Design Document

## Summary for Non-Technical Reviewers

TinaCMS is a content management system that would give you a friendly editing interface for writing blog posts directly on your website. You would log in, see a simple form with fields for title, date, image, and text, type your post, and hit save. Behind the scenes it saves everything as files in the same place your website code lives, which triggers an automatic rebuild and publish. There is nothing to host separately and no database to maintain.

The free tier supports two users and one project -- more than enough for a single-editor photography blog.

The main decision this document asks you to review is **how images are positioned within blog posts** (Option A vs Option B in the Image Positioning section below).

---

## Table of Contents

1. [Recommended Integration Approach](#recommended-integration-approach)
2. [Proposed Content Schema](#proposed-content-schema)
3. [Image Positioning Approaches](#image-positioning-approaches)
4. [Build and Deploy Flow](#build-and-deploy-flow)
5. [Compatibility with Existing Setup](#compatibility-with-existing-setup)
6. [Blockers, Gotchas, and Open Questions](#blockers-gotchas-and-open-questions)
7. [Estimated Effort](#estimated-effort)

---

## Recommended Integration Approach

**Use TinaCMS with TinaCloud (free tier) and the sidebar form editor.**

### Why TinaCMS

- **Git-backed**: All content is stored as Markdown files committed to the repository. No external database, no vendor lock-in. If TinaCMS is ever removed, the blog posts remain as plain Markdown.
- **Astro support**: First-class integration via `@tinacms/cli`. The generated GraphQL client works seamlessly in Astro frontmatter.
- **Non-technical editing**: The admin UI at `/admin/index.html` provides a clean form-based editor with a media manager for uploading images.
- **Free tier is sufficient**: 2 users, 1 project, unlimited documents. A single editor on a single site fits perfectly.

### Why the sidebar editor (not visual editing)

TinaCMS offers an experimental visual/contextual editor for Astro, but it requires wrapping editable content in React components with a custom hydration directive. Given that the site uses Astro components and ReScript, adding React wrappers solely for visual editing adds complexity with marginal benefit. The sidebar form editor provides the same fields and media manager without any component changes.

### Installation overview

```bash
npx @tinacms/cli@latest init    # scaffolds tina/ directory with config.ts
npx tinacms dev -c "astro dev"  # runs local dev with TinaCMS admin
```

The `tina/config.ts` file defines all content schemas. TinaCMS generates a typed GraphQL client at `tina/__generated__/client` for querying content in Astro frontmatter.

---

## Proposed Content Schema

```ts
// tina/config.ts (simplified)
import { defineConfig } from "tinacms";

export default defineConfig({
  branch: process.env.TINA_BRANCH || "main",
  clientId: process.env.TINA_CLIENT_ID || "",
  token: process.env.TINA_TOKEN || "",

  build: {
    outputFolder: "admin",
    publicFolder: "public",
  },

  media: {
    tina: {
      mediaRoot: "uploads",
      publicFolder: "public",
    },
  },

  schema: {
    collections: [
      {
        label: "Blog Posts",
        name: "post",
        path: "src/content/blog",
        format: "md",
        fields: [
          {
            label: "Title",
            name: "title",
            type: "string",
            required: true,
          },
          {
            label: "Publish Date",
            name: "publishDate",
            type: "datetime",
            required: true,
          },
          {
            label: "Author",
            name: "author",
            type: "string",
            // Default to site owner; editable if guest posts are added later
          },
          {
            label: "Featured Image",
            name: "featuredImage",
            type: "image",
            required: true,
          },
          {
            label: "Featured Image Alt Text",
            name: "featuredImageAlt",
            type: "string",
            required: true,
          },
          {
            label: "Excerpt",
            name: "excerpt",
            type: "string",
            ui: {
              component: "textarea",
            },
          },
          {
            label: "Body",
            name: "body",
            type: "rich-text",
            isBody: true,
          },
        ],
      },
    ],
  },
});
```

### Astro Content Collection registration

A new `blog` collection would be added to `src/content.config.ts`:

```ts
const blog = defineCollection({
  loader: glob({ pattern: "**/*.md", base: "src/content/blog" }),
  schema: z.object({
    title: z.string(),
    publishDate: z.string(),
    author: z.string().optional(),
    featuredImage: z.string(),
    featuredImageAlt: z.string(),
    excerpt: z.string().optional(),
  }),
});
```

Both TinaCMS and Astro Content Collections read the same Markdown files. TinaCMS writes them; Astro reads them at build time.

### Data fetching in Astro pages

```astro
---
// src/pages/blog/[slug].astro
import { getCollection } from "astro:content";

export async function getStaticPaths() {
  const posts = await getCollection("blog");
  return posts.map((post) => ({
    params: { slug: post.id },
    props: { post },
  }));
}

const { post } = Astro.props;
const { Content } = await render(post);
---

<Main title={post.data.title}>
  <article>
    <h1>{post.data.title}</h1>
    <time>{post.data.publishDate}</time>
    <img src={post.data.featuredImage} alt={post.data.featuredImageAlt} />
    <Content />
  </article>
</Main>
```

---

## Image Positioning Approaches

Two approaches for controlling how images appear within blog post bodies:

### Option A: Custom Field with CSS Class Mapping

Add a select/enum field to the TinaCMS schema for image layout. The editor picks a layout style from a dropdown and a corresponding CSS class is applied at render time.

**Schema addition:**

```ts
{
  label: "Featured Image Position",
  name: "featuredImagePosition",
  type: "string",
  options: [
    { label: "Full Width (above content)", value: "full-width" },
    { label: "Left (text wraps right)", value: "float-left" },
    { label: "Right (text wraps left)", value: "float-right" },
    { label: "Center (inline with text)", value: "center" },
  ],
}
```

**Rendering:**

```astro
<img
  src={post.data.featuredImage}
  alt={post.data.featuredImageAlt}
  class={imagePositionClasses[post.data.featuredImagePosition]}
/>
```

| Pros | Cons |
|------|------|
| Simple for the editor -- one dropdown | Only controls the **featured** image, not inline images |
| No MDX needed -- works with plain Markdown | Limited to pre-defined layouts |
| Easy to style consistently across all posts | Adding new layouts requires a code change |
| Zero learning curve for the editor | |

### Option B: Rich Text Block Templates (MDX)

Define custom "image block" templates within the rich-text body field. The editor inserts image blocks at any point in the post, each with its own layout and caption fields.

**Schema addition:**

```ts
{
  label: "Body",
  name: "body",
  type: "rich-text",
  isBody: true,
  templates: [
    {
      name: "positionedImage",
      label: "Image with Layout",
      fields: [
        { name: "src", label: "Image", type: "image", required: true },
        { name: "alt", label: "Alt Text", type: "string", required: true },
        { name: "caption", label: "Caption", type: "string" },
        {
          name: "layout",
          label: "Layout",
          type: "string",
          options: ["full-width", "float-left", "float-right", "center"],
        },
      ],
    },
  ],
}
```

**Rendering:** Requires switching from `.md` to `.mdx` format and creating a `PositionedImage` component that TinaCMS maps to during rendering.

| Pros | Cons |
|------|------|
| Full control over every image in the post | More complex for the editor (insert block, fill fields) |
| Images can appear anywhere in the flow | Requires MDX instead of plain Markdown |
| Each image gets its own caption and layout | Slightly more complex build pipeline |
| Extensible -- new block types (video, gallery, callout) can be added | Steeper learning curve for a non-technical editor |

### Recommendation

**Start with Option A** for the initial implementation. It covers the most common blog use case (a featured image with a layout choice) and keeps the editing experience as simple as possible for a non-technical user. Option B can be introduced later if the editor needs more flexible image placement within post bodies.

---

## Build and Deploy Flow

```
Editor saves post in TinaCMS admin
        |
        v
TinaCloud commits Markdown file to GitHub repo
        |
        v
GitHub push triggers CI/CD rebuild (Cloudflare Pages, Netlify, or Vercel)
        |
        v
Astro builds static site (reads Markdown via Content Collections)
        |
        v
Site deployed with new blog post live
```

**Local development:** Running `npx tinacms dev -c "astro dev"` starts a local GraphQL server. Edits are saved directly to disk as Markdown files. No Git commit happens automatically -- the developer commits when ready.

**Production (TinaCloud):** Edits through the hosted admin UI at `yourdomain.com/admin/index.html` are committed to the configured branch on GitHub. The hosting platform detects the push and rebuilds.

**Current deployment note:** The site currently builds to the `docs/` directory and uses Cloudflare Workers (Wrangler). The TinaCMS admin panel would be built to `public/admin/` and served as a static route. The Astro build itself is unaffected.

---

## Compatibility with Existing Setup

| Concern | Assessment |
|---------|------------|
| **Astro Content Collections** | Compatible. TinaCMS writes Markdown files that Astro reads via glob loaders. The existing 8 collections are unaffected. A new `blog` collection is added alongside them. |
| **ReScript pipeline** | No conflict. TinaCMS only touches content files (Markdown/JSON). The ReScript compiler and `.res.mjs` imports are independent. |
| **Preact integration** | No conflict. TinaCMS admin is a self-contained React app served from `/admin/`. It does not interact with the site's Preact components. |
| **Tailwind CSS v4** | No conflict. Blog post styles can use the existing theme tokens (pink, mint, pastel-green, etc.). |
| **Build output (`docs/`)** | TinaCMS admin builds to `public/admin/`, which Astro copies to `docs/admin/` during build. No configuration clash. |
| **Cloudflare Workers** | The admin route needs to be accessible. If using Cloudflare Pages, it works out of the box. If using Workers with custom routing, ensure `/admin/*` routes serve the static admin files. |

---

## Blockers, Gotchas, and Open Questions

### Blockers

None identified. The integration is straightforward for the sidebar editor approach.

### Gotchas

1. **Media storage limit (100 MB)**: TinaCloud's free tier includes only 100 MB of media storage across all tiers except Enterprise. For a photography blog, this will be reached quickly. **Mitigation:** Use an external media provider (Cloudinary or AWS S3) from day one, or optimize/resize images before upload. Alternatively, store images in the Git repo directly (`public/uploads/`) and accept the repo size growth.

2. **Admin route**: The TinaCMS admin panel lives at `/admin/index.html`, not `/admin`. A redirect or rewrite rule improves the experience. The starter template includes this, but it may need to be added manually.

3. **Generated client**: The `tina/__generated__/` directory must be committed to the repo (or regenerated in CI). Schema changes require running `npx tinacms dev` or `npx tinacms build` to update the generated client.

4. **TinaCloud requires GitHub**: The Git provider integration is GitHub-centric. If the repo is hosted elsewhere, a self-hosted backend would be needed instead.

5. **Visual editing is experimental for Astro**: If the editor later wants a WYSIWYG-style live preview, it would require wrapping blog content in React components. This is achievable but adds complexity.

### Open Questions

1. **Image hosting strategy**: Should blog images live in the Git repo (`public/uploads/`) or use an external service (Cloudinary, S3)? The repo approach is simpler but grows the repo over time. External hosting adds a dependency but scales better.

2. **Blog URL structure**: Should posts live at `/blog/[slug]` or a different path? This affects routing and SEO.

3. **Deployment platform confirmation**: The current Wrangler/Cloudflare Workers setup may need adjustment to serve the TinaCMS admin panel. Cloudflare Pages would be simpler for this use case.

4. **Editorial workflow**: The free tier does not include branch-based editorial workflow (draft -> review -> publish). Is a simple "save and publish" flow acceptable, or is a draft/review process needed (requiring the Team Plus tier at $41/month)?

---

## Estimated Effort

| Task | Estimate |
|------|----------|
| TinaCMS installation and configuration | 2-3 hours |
| Blog content schema and Astro collection | 1-2 hours |
| Blog listing page (`/blog`) | 2-3 hours |
| Blog post page (`/blog/[slug]`) | 2-3 hours |
| Featured image positioning (Option A) | 1-2 hours |
| Styling blog pages to match site theme | 3-4 hours |
| TinaCloud setup (project, auth, tokens) | 1-2 hours |
| Admin route and deployment config | 1-2 hours |
| Testing and QA | 2-3 hours |
| **Total** | **15-24 hours** |

If Option B (rich text blocks with MDX) is chosen instead, add 4-6 hours for the MDX pipeline setup, block component development, and additional editor testing.

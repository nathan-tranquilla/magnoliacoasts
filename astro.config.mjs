// @ts-check
import { defineConfig } from "astro/config";
import rehypeUnwrapImages from "rehype-unwrap-images";
import tailwindcss from "@tailwindcss/vite";

import sitemap from "@astrojs/sitemap";
import preact from "@astrojs/preact";
import mdx from "@astrojs/mdx";

// https://astro.build/config
export default defineConfig({
  site: "https://magnoliacoastsphotography.com",
  vite: {
    plugins: [tailwindcss()],
  },

  outDir: "docs",
  image: {
    layout: "constrained",
    objectFit: "cover",
  },
  markdown: {
    rehypePlugins: [rehypeUnwrapImages],
  },
  build: {
    inlineStylesheets: "always",
  },

  integrations: [sitemap(), preact({ compat: true }), mdx()],
});

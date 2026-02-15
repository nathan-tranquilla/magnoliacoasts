// @ts-check
import { defineConfig } from "astro/config";
import rehypeUnwrapImages from "rehype-unwrap-images";
import tailwindcss from "@tailwindcss/vite";

import sitemap from "@astrojs/sitemap";
import react from "@astrojs/react";

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

  integrations: [sitemap(), react()],
});

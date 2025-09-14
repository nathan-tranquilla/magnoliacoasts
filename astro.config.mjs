// @ts-check
import { defineConfig } from 'astro/config';
import rehypeUnwrapImages from 'rehype-unwrap-images';
import tailwindcss from '@tailwindcss/vite';

import cloudflare from '@astrojs/cloudflare';

// https://astro.build/config
export default defineConfig({
  vite: {
    plugins: [tailwindcss()]
  },

  outDir: 'docs',

  markdown: {
    rehypePlugins: [rehypeUnwrapImages],
  },

  build: {
    inlineStylesheets: 'always'
  },

  adapter: cloudflare()
});
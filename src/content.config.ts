// 1. Import utilities from `astro:content`
import { defineCollection, z } from 'astro:content';

// 2. Import loader(s)
import { glob } from 'astro/loaders';

// 3. Define your collection(s)
const maternityPackages = defineCollection({ 
  loader: glob({ pattern: "*.md", base: "./src/data/maternityPackages" }),
  schema: z.object({
    title: z.string(),
    sortOrder: z.number(),
    details: z.array(z.string()),
    price: z.number()
  }),
});

const newbornPackages = defineCollection({ 
  loader: glob({ pattern: "*.md", base: "./src/data/newbornPackages" }),
  schema: z.object({
    title: z.string(),
    sortOrder: z.number(),
    details: z.array(z.string()),
    price: z.number()
  }),
});

// 4. Export a single `collections` object to register your collection(s)
export const collections = { maternityPackages, newbornPackages };
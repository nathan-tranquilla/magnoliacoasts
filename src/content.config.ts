// 1. Import utilities from `astro:content`
import { defineCollection, z } from 'astro:content';

// 2. Import loader(s)
import { glob } from 'astro/loaders';

// 3. Define your collection(s)
const packageSchema = z.object({
  title: z.string(),
  sortOrder: z.number(),
  details: z.array(z.string()),
  price: z.number().optional(),
  priceRange: z.string().optional()
}).refine(
  (data) => typeof data.price === 'number' || (data.priceRange && data.priceRange.length > 0),
  { message: "Either price or priceRange must be specified." }
);

const maternityPackages = defineCollection({ 
  loader: glob({ pattern: "*.md", base: "./src/data/maternityPackages" }),
  schema: packageSchema,
});

const newbornPackages = defineCollection({ 
  loader: glob({ pattern: "*.md", base: "./src/data/newbornPackages" }),
  schema: packageSchema,
});

const milestonePackages = defineCollection({ 
  loader: glob({ pattern: "*.md", base: "./src/data/milestonePackages" }),
  schema: packageSchema,
});

const familyPackages = defineCollection({ 
  loader: glob({ pattern: "*.md", base: "./src/data/familyPackages" }),
  schema: packageSchema,
});

const headshotPackages = defineCollection({ 
  loader: glob({ pattern: "*.md", base: "./src/data/headshotBrandingPortraitPackages" }),
  schema: packageSchema,
});

const collectionsPackages = defineCollection({ 
  loader: glob({ pattern: "*.md", base: "./src/data/collectionsPackages" }),
  schema: z.object({
    title: z.string(),
    sortOrder: z.number(),
    photoCount: z.number(),
    detailsCollection: z.record(z.string(), z.object({
      metadata: z.array(z.string()),
      details: z.array(z.string())
    })),
    price: z.number(),
    priceDetails: z.array(z.string())
  })
});

// 4. Export a single `collections` object to register your collection(s)
export const collections = { maternityPackages, newbornPackages, milestonePackages, familyPackages, headshotPackages, collectionsPackages};
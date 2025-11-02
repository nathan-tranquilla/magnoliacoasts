// 1. Import utilities from `astro:content`
import { defineCollection, z } from "astro:content";

// 2. Import loader(s)
import { glob, file } from "astro/loaders";

// 3. Define your collection(s)
const packageSchema = z
  .object({
    title: z.string(),
    sortOrder: z.number(),
    details: z.array(z.string()),
    price: z.number().optional(),
    priceRange: z.string().optional(),
    cardStyle: z.string().optional(),
    productLink: z.string(),
  })
  .refine(
    (data) =>
      typeof data.price === "number" ||
      (data.priceRange && data.priceRange.length > 0),
    { message: "Either price or priceRange must be specified." },
  );

const bannerMessages = defineCollection({
  loader: glob({ pattern: "*.md", base: "./src/data/bannerMessages" }),
  schema: z.object({
    templateId: z.string(),
    startDate: z.string(),
    endDate: z.string(),
  }),
});

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
  loader: glob({
    pattern: "*.md",
    base: "./src/data/headshotBrandingPortraitPackages",
  }),
  schema: packageSchema,
});

const collectionsPackages = defineCollection({
  loader: glob({ pattern: "*.md", base: "./src/data/collectionsPackages" }),
  schema: z.object({
    title: z.string(),
    sortOrder: z.number(),
    photoCount: z.number(),
    productLink: z.string(),
    detailsCollection: z.record(
      z.string(),
      z.object({
        metadata: z.array(z.string()),
        details: z.array(z.string()),
      }),
    ),
    price: z.number(),
    priceDetails: z.array(z.string()),
  }),
});

const welcomeContent = defineCollection({
  loader: glob({ pattern: "welcome.md", base: "./src/content" }),
  schema: z.object({
    title: z.string(),
  }),
});

const aboutContent = defineCollection({
  loader: glob({ pattern: "about.md", base: "./src/content" }),
  schema: z.object({}),
});

// 4. Export a single `collections` object to register your collection(s)
export const collections = {
  aboutContent,
  welcomeContent,
  maternityPackages,
  newbornPackages,
  milestonePackages,
  familyPackages,
  headshotPackages,
  collectionsPackages,
  bannerMessages,
};

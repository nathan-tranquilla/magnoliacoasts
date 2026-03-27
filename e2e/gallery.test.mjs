import { describe, it } from "node:test";
import assert from "node:assert/strict";
import { readFileSync, readdirSync } from "node:fs";
import { join, dirname } from "node:path";
import { fileURLToPath } from "node:url";

const __dirname = dirname(fileURLToPath(import.meta.url));
const galleryPagesDir = join(__dirname, "../src/pages/gallery");
const galleryAssetsDir = join(__dirname, "../src/assets/galleries");

const galleries = [
  "branding",
  "cakesmash",
  "children",
  "family",
  "headshots",
  "maternity",
  "milestones",
  "newborn",
];

describe("gallery pages use .webp glob pattern", () => {
  for (const gallery of galleries) {
    it(`${gallery}.astro references *.webp not *.jpg`, () => {
      const source = readFileSync(
        join(galleryPagesDir, `${gallery}.astro`),
        "utf8",
      );
      assert.ok(
        source.includes(`galleries/${gallery}/*.webp`),
        `Expected glob pattern "galleries/${gallery}/*.webp" in ${gallery}.astro`,
      );
      assert.ok(
        !source.includes(`galleries/${gallery}/*.jpg`),
        `Found legacy .jpg glob pattern in ${gallery}.astro — should be .webp`,
      );
    });
  }
});

describe("gallery asset directories contain .webp files", () => {
  for (const gallery of galleries) {
    it(`${gallery} assets are .webp`, () => {
      const files = readdirSync(join(galleryAssetsDir, gallery));
      const nonWebp = files.filter(
        (f) => !f.startsWith(".") && !f.endsWith(".webp"),
      );
      assert.deepEqual(
        nonWebp,
        [],
        `Non-.webp files found in galleries/${gallery}: ${nonWebp.join(", ")}`,
      );
      assert.ok(
        files.some((f) => f.endsWith(".webp")),
        `No .webp files found in galleries/${gallery}`,
      );
    });
  }
});

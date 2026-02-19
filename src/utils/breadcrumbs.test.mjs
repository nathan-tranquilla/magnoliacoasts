import { describe, it } from "node:test";
import assert from "node:assert/strict";
import {
  getSegmentName,
  buildBreadcrumbItems,
  buildBreadcrumbSchema,
  getPathInfo,
} from "./breadcrumbs.res.mjs";

describe("getSegmentName", () => {
  it("returns mapped name for known segments", () => {
    assert.equal(getSegmentName("gallery"), "Gallery");
    assert.equal(getSegmentName("cakesmash"), "Cake Smash");
    assert.equal(getSegmentName("headshot"), "Headshots");
  });

  it("capitalizes unknown segments", () => {
    assert.equal(getSegmentName("unknown"), "Unknown");
    assert.equal(getSegmentName("foo"), "Foo");
  });
});

describe("buildBreadcrumbItems", () => {
  const url = "https://magnoliacoastsphotography.com";

  it("returns only Home for root path", () => {
    const items = buildBreadcrumbItems("/", url);
    assert.equal(items.length, 1);
    assert.equal(items[0].name, "Home");
    assert.equal(items[0].position, 1);
    assert.equal(items[0].item, url + "/");
  });

  it("builds correct items for a single-level path", () => {
    const items = buildBreadcrumbItems("/gallery", url);
    assert.equal(items.length, 2);
    assert.equal(items[1].name, "Gallery");
    assert.equal(items[1].position, 2);
    assert.equal(items[1].item, url + "/gallery");
  });

  it("builds correct items for a nested path", () => {
    const items = buildBreadcrumbItems("/gallery/newborn", url);
    assert.equal(items.length, 3);
    assert.equal(items[0].name, "Home");
    assert.equal(items[1].name, "Gallery");
    assert.equal(items[1].item, url + "/gallery");
    assert.equal(items[2].name, "Newborn");
    assert.equal(items[2].position, 3);
    assert.equal(items[2].item, url + "/gallery/newborn");
  });

  it("handles trailing slash", () => {
    const items = buildBreadcrumbItems("/investment/", url);
    assert.equal(items.length, 2);
    assert.equal(items[1].name, "Investment");
  });
});

describe("buildBreadcrumbSchema", () => {
  const url = "https://magnoliacoastsphotography.com";

  it("returns null for root path", () => {
    assert.equal(buildBreadcrumbSchema("/", url), null);
  });

  it("returns valid JSON-LD for non-root paths", () => {
    const schema = JSON.parse(buildBreadcrumbSchema("/gallery/newborn", url));
    assert.equal(schema["@context"], "https://schema.org");
    assert.equal(schema["@type"], "BreadcrumbList");
    assert.equal(schema.itemListElement.length, 3);
  });
});

describe("getPathInfo", () => {
  it("returns empty arrays for root path", () => {
    const info = getPathInfo("/", "");
    assert.deepEqual(info.segments, []);
    assert.deepEqual(info.names, []);
    assert.deepEqual(info.hrefs, []);
  });

  it("returns correct segments, names, and hrefs", () => {
    const info = getPathInfo("/investment/maternity", "/base");
    assert.deepEqual(info.segments, ["investment", "maternity"]);
    assert.deepEqual(info.names, ["Investment", "Maternity"]);
    assert.deepEqual(info.hrefs, ["/base/investment", "/base/investment/maternity"]);
  });

  it("maps cakesmash to Cake Smash", () => {
    const info = getPathInfo("/gallery/cakesmash", "");
    assert.equal(info.names[1], "Cake Smash");
  });
});

// LD+JSON structured data builders for SEO

let websiteUrl = "https://magnoliacoastsphotography.com"

// WebSite schema — homepage only
let buildWebSiteSchema = (): string => {
  JSON.stringifyAny({
    "@context": "https://schema.org",
    "@type": "WebSite",
    "name": "Magnolia Coasts Photography",
    "url": websiteUrl,
  })->Option.getOr("")
}

// WebPage schema — all pages
let buildWebPageSchema = (pathname: string, name: string, description: string): string => {
  let url = websiteUrl ++ pathname
  JSON.stringifyAny({
    "@context": "https://schema.org",
    "@type": "WebPage",
    "name": name,
    "url": url,
    "description": description,
    "isPartOf": {
      "@type": "WebSite",
      "url": websiteUrl,
    },
  })->Option.getOr("")
}

// ImageGallery schema — gallery pages
type imageObject = {
  @as("@type") type_: string,
  name: string,
  contentUrl: string,
}

let buildImageGallerySchema = (
  name: string,
  pathname: string,
  imageCount: int,
): string => {
  let url = websiteUrl ++ pathname
  let images =
    Array.fromInitializer(~length=imageCount, i => {
      type_: "ImageObject",
      name: `${name} photo ${Int.toString(i + 1)}`,
      contentUrl: url,
    })

  JSON.stringifyAny({
    "@context": "https://schema.org",
    "@type": "ImageGallery",
    "name": `${name} Photography Gallery`,
    "url": url,
    "numberOfItems": imageCount,
    "image": images,
  })->Option.getOr("")
}

// Service schema — investment pages
type offer = {
  @as("@type") type_: string,
  price: string,
  priceCurrency: string,
}

type providerRef = {
  @as("@type") providerType: string,
  @as("name") providerName: string,
}

type serviceSchema = {
  @as("@context") context: string,
  @as("@type") type_: string,
  name: string,
  url: string,
  provider: providerRef,
  areaServed: string,
  offers: array<offer>,
}

let buildServiceSchema = (
  name: string,
  pathname: string,
  prices: array<string>,
): string => {
  let url = websiteUrl ++ pathname
  let offers = prices->Array.map(p => {
    type_: "Offer",
    price: p,
    priceCurrency: "CAD",
  })
  let schema: serviceSchema = {
    context: "https://schema.org",
    type_: "Service",
    name: name,
    url: url,
    provider: {
      providerType: "LocalBusiness",
      providerName: "Magnolia Coasts Photography",
    },
    areaServed: "Toronto, Ontario",
    offers: offers,
  }
  JSON.stringifyAny(schema)->Option.getOr("")
}

// Review schema — testimonials
type reviewAuthor = {
  @as("@type") type_: string,
  name: string,
}

type reviewRating = {
  @as("@type") ratingType: string,
  ratingValue: int,
  bestRating: int,
}

type review = {
  @as("@type") type_: string,
  author: reviewAuthor,
  reviewBody: string,
  datePublished: string,
  reviewRating: reviewRating,
}

type aggregateRating = {
  @as("@type") aggType: string,
  ratingValue: float,
  reviewCount: int,
  bestRating: int,
}

type aggregateRatingSchema = {
  @as("@context") context: string,
  @as("@type") type_: string,
  name: string,
  aggregateRating: aggregateRating,
  review: array<review>,
}

let buildReviewSchema = (
  reviews: array<(string, string, string)>,
): string => {
  let reviewItems = reviews->Array.map(((name, body, date)) => {
    type_: "Review",
    author: {type_: "Person", name},
    reviewBody: body,
    datePublished: date,
    reviewRating: {
      ratingType: "Rating",
      ratingValue: 5,
      bestRating: 5,
    },
  })

  let schema: aggregateRatingSchema = {
    context: "https://schema.org",
    type_: "LocalBusiness",
    name: "Magnolia Coasts Photography",
    aggregateRating: {
      aggType: "AggregateRating",
      ratingValue: 5.0,
      reviewCount: reviews->Array.length,
      bestRating: 5,
    },
    review: reviewItems,
  }
  JSON.stringifyAny(schema)->Option.getOr("")
}

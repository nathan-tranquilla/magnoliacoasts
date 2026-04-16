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
        format: "mdx",
        ui: {
          filename: {
            slugify: (values) => {
              return (values?.title || "")
                .toLowerCase()
                .replace(/\s+/g, "-")
                .replace(/[^a-z0-9-]/g, "");
            },
          },
        },
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
          },
          {
            label: "Featured Image",
            name: "featuredImage",
            type: "image",
          },
          {
            label: "Featured Image Alt Text",
            name: "featuredImageAlt",
            type: "string",
          },
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
            templates: [
              {
                name: "PositionedImage",
                label: "Image with Layout",
                fields: [
                  {
                    name: "src",
                    label: "Image",
                    type: "image",
                    required: true,
                  },
                  {
                    name: "alt",
                    label: "Alt Text",
                    type: "string",
                    required: true,
                  },
                  {
                    name: "caption",
                    label: "Caption",
                    type: "string",
                  },
                  {
                    name: "layout",
                    label: "Layout",
                    type: "string",
                    options: [
                      { label: "Full Width", value: "full-width" },
                      { label: "Left (text wraps right)", value: "float-left" },
                      {
                        label: "Right (text wraps left)",
                        value: "float-right",
                      },
                      { label: "Center", value: "center" },
                    ],
                  },
                ],
              },
            ],
          },
        ],
      },
    ],
  },
});

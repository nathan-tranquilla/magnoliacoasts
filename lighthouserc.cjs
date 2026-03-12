module.exports = {
  ci: {
    collect: {
      // CI overrides this with --collect.staticDistDir=./docs
      // Local uses the dev server via `rake lighthouse`
      url: ["http://localhost:4321/"],
      startServerCommand: "",
      numberOfRuns: 3,
    },
    assert: {
      assertions: {
        "categories:performance": ["warn", { minScore: 0.75 }],
        "categories:accessibility": ["error", { minScore: 0.9 }],
        "categories:best-practices": ["warn", { minScore: 0.9 }],
        "categories:seo": ["warn", { minScore: 0.9 }],
      },
    },
    upload: {
      target: "temporary-public-storage",
    },
  },
};

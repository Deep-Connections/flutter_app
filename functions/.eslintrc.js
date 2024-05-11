module.exports = {
  env: {
    es6: true,
    node: true,
  },
  parserOptions: {
    "ecmaVersion": 2018,
  },
  extends: [
    "eslint:recommended",
    "google",
    "plugin:mocha/recommended",
  ],
  rules: {
    "no-restricted-globals": ["error", "name", "length"],
    "prefer-arrow-callback": "error",
    "object-curly-spacing": ["error", "always"],
    "quotes": ["error", "double", { "allowTemplateLiterals": true }],
    "require-jsdoc": "off",
    "max-len": ["error", { "code": 120 }],
    "mocha/no-mocha-arrows": "off",
  },
  overrides: [
    {
      files: ["**/*.spec.*"],
      env: {
        mocha: true,
      },
      rules: {},
    },
  ],
  globals: {},
};

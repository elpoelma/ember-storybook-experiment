import { createRequire } from 'node:module';

import type { StorybookConfig } from 'ember-storybook';

const require = createRequire(`${process.cwd()}/`);

// Embroider injects the app config into the app's own `index.html` as a meta
// tag, where `app/config/environment.js` (@embroider/config-meta-loader)
// reads it. Storybook's preview iframe uses Storybook's own HTML, so we
// inject the same tag into the preview here.
type AppConfigFactory = (environment: string) => Record<string, unknown>;

const loadAppConfig = require('./config/environment.js') as AppConfigFactory;
const appConfig = loadAppConfig(
  process.env.NODE_ENV === 'production' ? 'production' : 'development',
);

const config: StorybookConfig = {
  stories: [
    '../app/stories/**/*.stories.g(j|t)s',
    '../app/docs/**/*.mdx',
  ],

  addons: ['@storybook/addon-docs'],

  framework: 'ember-storybook',

  previewHead: (head) =>
    `${head}<meta name="ember-storybook-experiment/config/environment" content="${encodeURIComponent(JSON.stringify(appConfig))}">`,
};

export default config;

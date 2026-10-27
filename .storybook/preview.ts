import { createApp } from '../app/app';

import type { Preview } from 'ember-storybook';

const preview: Preview = {
  parameters: {
    ember: {
      app: createApp,
    },
  },
};

export default preview;
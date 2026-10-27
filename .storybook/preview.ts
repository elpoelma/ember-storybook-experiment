import { createApp } from '../app/app';

import type { Preview } from 'ember-storybook';

const preview: Preview = {
  parameters: {
    controls: {
      matchers: {
        color: /(background|color)$/i,
        date: /Date$/i,
      },
    },
    options: {
      storySort: {
        order: [
          'Outline',
          [
            'Getting started',
            'Accessibility',
            'Coding standards',
            'Architecture and namespaces',
          ],
          'Variables',
          ['Colors', 'Colors: semantic', 'CSS Variables', 'Sass Variables'],
          'Objects',
          'Utilities',
          'Components',
        ],
      },
    },
    ember: {
      app: createApp,
    },
  },
};

export default preview;

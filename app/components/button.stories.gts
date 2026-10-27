import Button from './button.gts';

import type { Meta, StoryObj } from 'ember-storybook';

export default {
  title: 'Example/Button',
  // eslint-disable-next-line @typescript-eslint/no-unsafe-assignment
  component: Button,
} satisfies Meta;

export const Primary: StoryObj = {
  args: {},
};

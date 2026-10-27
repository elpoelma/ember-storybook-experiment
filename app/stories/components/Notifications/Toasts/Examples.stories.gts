

import type { Meta, StoryObj } from "ember-storybook";
import AuToaster, { type AuToasterSignature } from '@appuniversum/ember-appuniversum/components/au-toaster';
import AuToastDemo from "./au-toast-demo.gts";

type StoryArgs = AuToasterSignature['Args'];

export default {
  title: 'Components/Notifications/Toasts/Examples',
  parameters: {
    layout: 'padded',
  },
  argTypes: {
    position: {
      control: 'select',
      options: ['top', 'bottom'],
      description:
        'Control the position of the toaster. Default is at the top.',
    },
  },
  render: (args) => <template>
    {{! template-lint-disable no-args-paths }}
    <AuToaster @position={{args.position}} />
    <AuToastDemo />
  </template>,
} satisfies Meta<StoryArgs>;

export const Component: StoryObj<StoryArgs> = {
  args: {
    position: 'top',
  },
};
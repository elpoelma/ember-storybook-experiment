import AuButton, {
  type AuButtonSignature,
} from '@appuniversum/ember-appuniversum/components/au-button';
import type { Meta, StoryObj } from 'ember-storybook';

import { icons } from '../../assets/icons';

type StoryArgs = AuButtonSignature['Args'] & { text: string };

const defaultArgs = {
  text: 'Button',
  skin: 'primary',
  icon: '',
  iconAlignment: 'left',
  hideText: false,
  wrap: false,
  alert: false,
  disabled: false,
  loading: false,
} satisfies Partial<StoryArgs>;

export default {
  title: 'Components/Buttons/AuButton',
  component: AuButton,
  parameters: {
    layout: 'padded',
  },
  argTypes: {
    text: { control: 'text', description: '' },
    skin: {
      control: { type: 'select' },
      options: [
        'primary',
        'secondary',
        'naked',
        'link',
        'link-bold',
        'link-secondary',
      ],
      description: 'Defines the style of the button',
    },
    size: {
      control: 'select',
      options: ['', 'large'],
      description: 'Set the size of the button',
    },
    icon: { control: 'select', options: icons, description: 'Adds an icon' },
    iconAlignment: {
      control: 'select',
      options: ['', 'left', 'right'],
      description:
        'Choose the position of the icon, adds correct margin next to the icon',
    },
    hideText: {
      control: 'boolean',
      description: 'Hides the button text visually',
    },
    width: {
      control: 'select',
      options: ['', 'block'],
      description: 'Defines the width of a button',
    },
    wrap: {
      control: 'boolean',
      description: 'Wrap the text inside a button',
    },
    alert: {
      control: 'boolean',
      description: 'Adds an alert state to the button',
    },
    disabled: {
      control: 'boolean',
      description: 'Adds a disabled state to the button',
    },
    loading: {
      control: 'boolean',
      description: 'Adds a loading state to the button',
    },
    loadingMessage: {
      control: 'text',
      description: 'Add a custom loading message. Default is "Aan het laden"',
    },
  },
  render: (args) => <template>
    {{! template-lint-disable no-args-paths }}
    <AuButton
      @skin={{args.skin}}
      @size={{args.size}}
      @icon={{args.icon}}
      @iconAlignment={{args.iconAlignment}}
      @hideText={{args.hideText}}
      @width={{args.width}}
      @wrap={{args.wrap}}
      @alert={{args.alert}}
      @disabled={{args.disabled}}
      @loading={{args.loading}}
      @loadingMessage={{args.loadingMessage}}
    >
      {{args.text}}
    </AuButton>
  </template>,
} satisfies Meta<StoryArgs>;

export const Primary: StoryObj<StoryArgs> = {
  args: {
    ...defaultArgs,
    skin: 'primary',
  },
};

export const Secondary: StoryObj<StoryArgs> = {
  args: {
    ...defaultArgs,
    skin: 'secondary',
  },
};

export const PrimaryLink: StoryObj<StoryArgs> = {
  args: {
    ...defaultArgs,
    text: 'Primary link',
    skin: 'link',
  },
};

export const SecondaryLink: StoryObj<StoryArgs> = {
  args: {
    ...defaultArgs,
    text: 'Secondary link',
    skin: 'link-secondary',
  },
};

export const BoldLink: StoryObj<StoryArgs> = {
  args: {
    ...defaultArgs,
    text: 'Bold link',
    skin: 'link-bold',
  },
};

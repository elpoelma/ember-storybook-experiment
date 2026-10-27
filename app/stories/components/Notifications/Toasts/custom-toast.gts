import AuAlert, {
  type AuAlertSignature,
} from '@appuniversum/ember-appuniversum/components/au-alert';
import AuButton from '@appuniversum/ember-appuniversum/components/au-button';
import AuButtonGroup from '@appuniversum/ember-appuniversum/components/au-button-group';
import AuLinkExternal from '@appuniversum/ember-appuniversum/components/au-link-external';
import type { TOC } from '@ember/component/template-only';
import Component from '@glimmer/component';

type Signature = {
  Args: {
    options: Pick<
      AuAlertSignature['Args'],
      'title' | 'skin' | 'icon' | 'closable'
    > & {
      someHandler: () => unknown;
    };
    close: AuAlertSignature['Args']['onClose'];
  };
};

// eslint-disable-next-line ember/no-empty-glimmer-component-classes
export default class CustomToast extends Component<Signature> {
  <template>
    <AuAlert
      @title={{@options.title}}
      @skin={{@options.skin}}
      @icon={{@options.icon}}
      @size="small"
      @closable={{@options.closable}}
      @onClose={{@close}}
    >
      <AuButtonGroup>
        <AuButton {{on "click" @options.someHandler}}>Custom action</AuButton>
        <AuLinkExternal href="https://vlaanderen.be">Meer info</AuLinkExternal>
      </AuButtonGroup>
    </AuAlert>
  </template>
}

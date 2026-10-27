import Component from '@glimmer/component';
import { service } from '@ember/service';
import { action } from '@ember/object';
import { tracked } from '@glimmer/tracking';
import CustomToast from './custom-toast';
import type ToasterService from '@appuniversum/ember-appuniversum/services/toaster';
import type { ToastData } from '@appuniversum/ember-appuniversum/services/toaster';
import AuContent from '@appuniversum/ember-appuniversum/components/au-content';
import AuHeading from '@appuniversum/ember-appuniversum/components/au-heading';
import AuHr from '@appuniversum/ember-appuniversum/components/au-hr';
import AuButton from '@appuniversum/ember-appuniversum/components/au-button';
import AuPill from '@appuniversum/ember-appuniversum/components/au-pill';

export default class AuToastDemo extends Component {
  @service declare toaster: ToasterService;
  @tracked clearableToast?: ToastData;

  @action
  triggerToast() {
    this.toaster.notify('Message', 'Notify');
  }

  @action
  triggerSuccessToast() {
    this.toaster.success('Message', 'Success');
  }

  @action
  triggerWarningToast() {
    this.toaster.warning('Message', 'Warning');
  }

  @action
  triggerErrorToast() {
    this.toaster.error('Message', 'Error');
  }

  @action
  triggerLoadingToast() {
    this.toaster.loading('Message', 'Loading');
  }

  @action
  triggerTimeoutToast() {
    this.toaster.notify('Message', 'Timeout', {
      timeOut: 3000,
      closable: false,
    });
  }

  @action
  triggerClearableToast() {
    this.clearableToast = this.toaster.warning(
      'This toast will be closed when clicking the "Close toast" button',
      'Close me with code',
    );
  }

  @action
  triggerClearToast() {
    if (this.clearableToast) {
      this.toaster.close(this.clearableToast);
    }
  }

  @action
  triggerCustomToast() {
    this.toaster.show(CustomToast, {
      someHandler: () => {
        alert('Custom handler triggered');
      },
    });
  }

  <template>
    <AuContent>
      <AuHeading @level="1" @skin="2">
        Examples
      </AuHeading>

      <div class="au-o-flow au-o-flow--tiny">
        <AuHeading @level="2" @skin="3">
          Toaster types
        </AuHeading>
        <AuHeading @level="3" @skin="4">
          Notify
        </AuHeading>
        <p class="au-u-margin-bottom-small">
          <AuPill>this.toaster.notify('Message','Notify');</AuPill>
        </p>

        <AuButton @skin="secondary" {{on "click" this.triggerToast}}>
          Trigger notify toast
        </AuButton>

        <AuHr />

        <AuHeading @level="2" @skin="5">
          Success
        </AuHeading>

        <p class="au-u-margin-bottom-small">
          <AuPill>this.toaster.success('Message','Success');</AuPill>
        </p>

        <AuButton @skin="secondary" {{on "click" this.triggerSuccessToast}}>
          Trigger success toast
        </AuButton>

        <AuHr />

        <AuHeading @level="2" @skin="5">
          Warning
        </AuHeading>
        <p class="au-u-margin-bottom-small">
          <AuPill>this.toaster.warning('Message','Warning');</AuPill>
        </p>

        <AuButton @skin="secondary" {{on "click" this.triggerWarningToast}}>
          Trigger warning toast
        </AuButton>

        <AuHr />

        <AuHeading @level="2" @skin="5">
          Error
        </AuHeading>
        <p class="au-u-margin-bottom-small">
          <AuPill>this.toaster.error('Message','Error');</AuPill>
        </p>

        <AuButton @skin="secondary" {{on "click" this.triggerErrorToast}}>
          Trigger error toast
        </AuButton>
        <AuHr />

        <AuHeading @level="2" @skin="5">
          Loading
        </AuHeading>
        <p class="au-u-margin-bottom-small">
          <AuPill>this.toaster.loading('Message','Loading');</AuPill>
        </p>

        <AuButton @skin="secondary" {{on "click" this.triggerLoadingToast}}>
          Trigger loading toast
        </AuButton>
      </div>

      <div class="au-o-flow au-o-flow--tiny">
        <AuHeading @level="2" @skin="3">
          "timeOut" option
        </AuHeading>
        <p class="au-u-margin-bottom-small">
          Toasts can be configured to auto-close when a certain time period has
          passed. This can be done by setting the `timeOut` property on the
          options object:
          <AuPill>this.toaster.notify('Message','Timeout',{ timeOut: 3000,
            closable: false });</AuPill>
        </p>

        <AuButton @skin="secondary" {{on "click" this.triggerTimeoutToast}}>
          Trigger toast with a timeout
        </AuButton>
      </div>

      <div class="au-o-flow au-o-flow--tiny">
        <AuHeading @level="2" @skin="3">
          Closing toasts from code
        </AuHeading>
        <p class="au-u-margin-bottom-small">
          Toasts can be closed programmatically by using the `close` method on
          the toaster service:
          <AuPill>this.toaster.close(this.toastObject);</AuPill>
        </p>

        <AuButton @skin="secondary" {{on "click" this.triggerClearableToast}}>
          Trigger toast
        </AuButton>
        <AuButton @skin="secondary" {{on "click" this.triggerClearToast}}>
          Close toast
        </AuButton>
      </div>

      <div class="au-o-flow au-o-flow--tiny">
        <AuHeading @level="2" @skin="3">
          Custom toast components
        </AuHeading>
        <p class="au-u-margin-bottom-small">
          <AuPill>this.toaster.show(CustomToastClass);</AuPill>
        </p>

        <AuButton @skin="secondary" {{on "click" this.triggerCustomToast}}>
          Trigger custom toast
        </AuButton>
      </div>

    </AuContent>
  </template>
}

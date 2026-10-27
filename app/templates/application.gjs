import { pageTitle } from 'ember-page-title';
import { WelcomePage } from 'ember-welcome-page';

<template>
  {{pageTitle "EmberStorybookExperiment"}}

  {{outlet}}

  {{! The following component displays Ember's default welcome message. }}
  <WelcomePage @extension="gjs" />
  {{! Feel free to remove this! }}
</template>

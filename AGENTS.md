# AGENTS.md

Guidance for AI coding agents working in this repository.

## Project Overview

Ember 7 application used to experiment with running Storybook 10 against Ember
components via the [`ember-storybook`](https://github.com/ember-integrations/ember-storybook)
addon (modeled on that repo's `demo` app). Builds go through Embroider:
`ember-cli-build.mjs` uses `compatBuild(app, buildOnce)` and the Vite setup in
`vite.config.mjs` / `babel.config.mjs`.

Key stack versions: ember-source ~7.3, Embroider (compat 4.x / vite 1.x),
Storybook 10, Warp Drive ~5.8, TypeScript 6 with Glint, Vite 8.

## Commands

Package manager is **pnpm** (repo has `pnpm-lock.yaml`). If `pnpm` is not on
PATH, use `corepack pnpm ...`. Do not use npm/yarn — it will desync the lockfile.

```sh
corepack pnpm install        # install dependencies

corepack pnpm storybook       # Storybook dev server on port 6006
corepack pnpm build-storybook # static Storybook build

corepack pnpm lint            # all linters (js, types, format, templates, styles)
corepack pnpm lint:fix        # auto-fix everything
corepack pnpm lint:js         # ESLint (flat config, type-checked rules)
corepack pnpm lint:types      # Glint type check (ember-tsc --noEmit)
corepack pnpm format         # Prettier write
```

There are currently **no** `start`, `test`, or `build` npm scripts. Storybook is
the only way the app runs; there is no standalone Vite dev/build entry point.
Valid checks before finishing work: `lint`, and `storybook` /
`build-storybook` if it is expected to run.

## Layout & Conventions

- `app/` — application code. Components are colocated GTS/GJS files
  (e.g. `app/components/button.gts`).
- Stories live under `app/stories/` and are matched by the glob
  `../app/stories/**/*.stories.g(j|t)s` from `.storybook/main.ts`
  (e.g. `app/stories/components/buttons/AuButton.stories.gts`).
- Standalone docs pages are MDX files under `app/docs/`, matched by
  `../app/docs/**/*.mdx` (e.g. `app/docs/Outline/Getting-started.mdx`).
  Use `*.mdx`, **not** `*.stories.mdx` — CSF-in-MDX was removed in Storybook 8.
  MDX files import blocks from `@storybook/addon-docs/blocks`.
- `.storybook/preview.ts` imports `createApp` from `../app/app` and exposes it
  via `parameters.ember.app`.
- `ember-cli-build.mjs` — EmberApp + `compatBuild(app, buildOnce)` with
  `@warp-drive/core` `setConfig` (`compatWith: '5.8'`).
- `vite.config.mjs` — `@embroider/vite` plugins (`classicEmberSupport`,
  `ember`) plus `@rollup/plugin-babel` with `babelHelpers: 'runtime'`.
- `tsconfig.json` — extends `@ember/app-tsconfig`; includes `app/`,
  `tests/`, `types/`, `.storybook/`. Note the path aliases use the prefix
  `my-app/*` (not the package name).
- ESLint uses the new flat config (`eslint.config.mjs`) with type-checked
  TypeScript rules, plus `eslint-plugin-ember` (gjs/gts) and
  `eslint-plugin-warp-drive`.
- Prettier uses `prettier-plugin-ember-template-tag` — templates inside
  `<template>` tags get formatted; don't hand-align them.

### Style rules

- Write components as `.gts` files with `<template>` tags (colocated), not
  separate `.hbs` files.
- Place new stories next to the component they describe.
- Prefer named exports (`export const Primary: StoryObj = ...`) matching the
  existing story file style.
- `.env.development` is committed — never put secrets in it; use
  `.env.local` or `.env.[mode].local`.

## Known Issues / Current State

- The app has no `index.html` or `public/` directory: Storybook supplies its
  own HTML, so the classic `index.html` is not needed by the prebuild. Do not
  add a standalone `vite` entry point without restoring an `index.html` —
  `vite build` uses it as its entry module.

- `.storybook/main.ts` injects the app-config `<meta>` tag via `previewHead`:
  the preview iframe uses Storybook's HTML, so `app/config/environment.js`
  (`@embroider/config-meta-loader`) would otherwise fail with "config is not
  an object". Keep this hook.

- `app/app.js` merges the classic wiring (warp-drive install, resolver +
  compat-modules, initializers, inspector) with the `createApp` export
  required by `.storybook/preview.ts`.

- **pnpm 12 quirks** (settings live in `pnpm-workspace.yaml`, not `.npmrc`):
  `minimumReleaseAge: 0` opts out of the default 24h supply-chain age check
  (it rejects freshly published lockfile entries),
  `verifyDepsBeforeRun: false` stops pnpm from reinstalling before every
  script (a failed verification wiped `node_modules/.bin` once), and
  `allowBuilds: esbuild: false` acknowledges the blocked build scripts so
  `pnpm install` succeeds.
- Node >= 20.19.0 required.

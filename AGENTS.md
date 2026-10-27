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

There are currently **no** `start`, `test`, or `build` npm scripts — the
equivalent direct commands are documented in `README.md` (e.g. `pnpm exec vite`
for the dev server, `pnpm exec vite build` for builds). Valid checks before
finishing work: `lint`, and `storybook` if it is expected to run.

## Layout & Conventions

- `app/` — application code. Components are colocated GTS/GJS files
  (e.g. `app/components/button.gts`).
- Stories live **next to** components and are matched by the glob
  `../app/**/*.stories.g(j|t)s` from `.storybook/main.ts`
  (e.g. `app/components/button.stories.gts`).
- `.storybook/preview.ts` imports `createApp` from `../app/app` and exposes it
  via `parameters.ember.app`. `app/app.js` also exports a `start(instance)`
  helper.
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

- **Storybook works.** It was fixed by restoring the classic Embroider build
  pipeline files (`config/`, `app/router.js`, `app/deprecation-workflow.js`,
  `app/config/environment.js`, `app/styles/app.css`, `public/`, and the
  classic `index.html` with `{{content-for}}` hooks) that the WIP deletions
  had removed. `classicEmberSupport()` in `vite.config.mjs` spawns
  `ember build --watch`, which requires those files.
- `.storybook/main.ts` injects the app-config `<meta>` tag via `previewHead`:
  the preview iframe uses Storybook's HTML, not the app's `index.html`, so
  `app/config/environment.js` (`@embroider/config-meta-loader`) would
  otherwise fail with "config is not an object". Keep this hook.
- `app/app.js` merges the classic wiring (warp-drive install, resolver +
  compat-modules, initializers, inspector) with the `createApp`/`start`
  exports required by `.storybook/preview.ts`.
- **pnpm 12 quirks** (settings live in `pnpm-workspace.yaml`, not `.npmrc`):
  `minimumReleaseAge: 0` opts out of the default 24h supply-chain age check
  (it rejects freshly published lockfile entries),
  `verifyDepsBeforeRun: false` stops pnpm from reinstalling before every
  script (a failed verification wiped `node_modules/.bin` once), and
  `allowBuilds: esbuild: false` acknowledges the blocked build scripts so
  `pnpm install` succeeds.
- The classic→demo migration (Vite-first, no ember-cli: drop
  `ember-cli-build.mjs` + `classicEmberSupport()`, adopt
  `ember-strict-application-resolver` + `#app/*` imports) was **not** done;
  the hybrid pipeline was restored instead. It remains a possible follow-up.
- Still deleted from the original app (fine for Storybook/dev): `tests/`,
  `testem.cjs`, `app/services/store.js`, `app/helpers/` + `app/controllers/`
  placeholders. There is no test setup.
- `types/` directory referenced by `tsconfig.json` does not exist yet.
- Node >= 20.19.0 required.

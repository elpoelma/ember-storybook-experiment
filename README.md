# ember-storybook-experiment

An Ember 7 application for experimenting with
[Storybook 10](https://storybook.js.org) via the
[`ember-storybook`](https://github.com/ember-integrations/ember-storybook)
addon (modeled on that repo's `demo` app). Builds run through
[Embroider](https://embroider.build) on [Vite](https://vite.dev).

## Prerequisites

- [Git](https://git-scm.com/)
- [Node.js](https://nodejs.org/) >= 20.19.0
- [pnpm](https://pnpm.io/) (if it is not on your PATH, prefix the commands
  below with `corepack`, e.g. `corepack pnpm install`)

## Installation

- `git clone <repository-url>` this repository
- `cd ember-storybook-experiment`
- `pnpm install`

## Running / Development

- `pnpm storybook` — start the Storybook dev server on
  [http://localhost:6006](http://localhost:6006)
- `pnpm build-storybook` — produce a static Storybook build (output in
  `storybook-static/`)

Stories live under `app/stories/` and are matched by the glob
`app/stories/**/*.stories.g(j|t)s`; standalone docs pages live under `app/docs/`
and are `*.mdx` files (not `*.stories.mdx`) — see `.storybook/main.ts`.

### Code Generators

Make use of the many generators for code, try `pnpm exec ember help generate`
for more details.

### Building

The app only runs inside Storybook, so there is no standalone app build. Use
`pnpm build-storybook` to produce a static Storybook build.

### Tests

There is currently no test setup in this experiment (the classic `tests/`
tree was removed as part of the Embroider/Vite migration).

### Linting

- `pnpm lint` — run all linters
- `pnpm lint:fix` — auto-fix everything
- `pnpm lint:js` — ESLint (includes type-checked rules for `.ts`/`.gts`)
- `pnpm lint:types` — Glint type check
- `pnpm lint:format` — check formatting
- `pnpm format` — apply Prettier formatting

## Further Reading / Useful Links

- [ember.js](https://emberjs.com/)
- [Vite](https://vite.dev)
- [Storybook](https://storybook.js.org)
- [ember-storybook demo app](https://github.com/ember-integrations/ember-storybook/tree/main/demo)

# homebrew-tap-staging

> ⚠️ This tap hosts **pre-release** builds of [envee](https://github.com/baken667/envee).
> Use only for testing features before they reach the stable channel.

## What's here

| Formula  | Source                                    | Channel   |
|----------|-------------------------------------------|-----------|
| `envee`  | tags matching `v*-rc.*`, `v*-beta.*`, `v*-alpha.*` on [`baken667/envee`](https://github.com/baken667/envee) | Pre-release |

## Install

```bash
brew install baken667/tap-staging/envee
```

## Stable channel

For production use, install from the stable tap:

```bash
brew install baken667/tap/envee
# https://github.com/baken667/homebrew-tap
```

## How it works

Every time a tag like `v0.2.0-rc.1` is pushed to the `staging` branch of
`baken667/envee`, GitHub Actions runs `release-staging.yml` which uses
GoReleaser to build the binaries, generate checksums, and update the
`Formula/envee.rb` file in **this** repo (not the stable tap).

The resulting GitHub Release is always marked as **prerelease** so it
doesn't show up in Homebrew's stable search.

## Removing the tap

```bash
brew uninstall envee
brew untap baken667/tap-staging
```

## Report issues

Open an issue on [baken667/envee](https://github.com/baken667/envee/issues)
and tag it with `staging` so we know which build you tested.

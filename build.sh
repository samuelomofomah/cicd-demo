#!/usr/bin/env bash
# BUILD: turn the source in site/ into the finished product in dist/.
# It copies the page and stamps it with a release number, a change ID and a
# timestamp, so anyone looking at the live site can tell which version it is.
set -euo pipefail

BUILD_NUMBER="${BUILD_NUMBER:-local}"
COMMIT_SHA="${COMMIT_SHA:-local}"
BUILT_AT="$(date -u '+%Y-%m-%d %H:%M UTC')"

rm -rf dist
cp -r site dist

sed -i.bak \
  -e "s|__BUILD_NUMBER__|${BUILD_NUMBER}|g" \
  -e "s|__COMMIT_SHA__|${COMMIT_SHA:0:7}|g" \
  -e "s|__BUILT_AT__|${BUILT_AT}|g" \
  dist/index.html
rm -f dist/index.html.bak

echo "Built release #${BUILD_NUMBER} (${COMMIT_SHA:0:7}) into dist/"

#!/usr/bin/env bash
#
# Generate Dolibarr stubs from the source directory.
#

HEADER=$'/**\n * Generated stub declarations for Dolibarr.\n * @see https://dolibarr.org\n * @see https://github.com/rycks/dolibarr-stubs\n */'

FILE="dolibarr-stubs.php"

set -e

# test -f "$FILE"
test -d "source/dolibarr"

# Exclude globals.
"$(dirname "$0")/vendor/bin/generate-stubs" \
    --include-inaccessible-class-nodes \
    --force \
    --finder=finder.php \
    --header="$HEADER" \
    --functions \
    --classes \
    --interfaces \
    --traits \
    --out="$FILE"

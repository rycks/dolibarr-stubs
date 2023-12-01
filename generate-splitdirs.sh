#!/usr/bin/env bash
#
# Generate Dolibarr stubs from the source directory.
#

HEADER=$'/**\n * Generated stub declarations for Dolibarr.\n * @see https://dolibarr.org\n * @see https://github.com/rycks/dolibarr-stubs\n */'
VERSION="18"

RUNFROM=$PWD
DEST="${RUNFROM}/dolibarr-${VERSION}"

set -e

# test -f "$FILE"
test -d "source/dolibarr"

# Exclude globals.
(
    cd source/dolibarr/htdocs
    for dir in *
    do
        if [ -d "${dir}" ]; then
            echo "run for ${dir} ..."
            # --finder=finder.php \
            ${RUNFROM}/vendor/bin/generate-stubs \
                ${dir} \
                --include-inaccessible-class-nodes \
                --force \
                --header="$HEADER" \
                --functions \
                --classes \
                --interfaces \
                --traits \
                --constants \
                --documented-globals \
                --out="${DEST}/${dir}.php"
        fi
    done
    #php files in root htdocs ...
    ${RUNFROM}/vendor/bin/generate-stubs \
        *.php \
        --include-inaccessible-class-nodes \
        --force \
        --header="$HEADER" \
        --functions \
        --classes \
        --interfaces \
        --traits \
        --constants \
        --documented-globals \
        --out="${DEST}/dolibarr.php"
)

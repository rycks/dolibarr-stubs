#!/usr/bin/env bash
#
# Generate Dolibarr stubs from the source directory.
#

HEADER=$'/**\n * Generated stub declarations for Dolibarr.\n * @see https://dolibarr.org\n * @see https://github.com/rycks/dolibarr-stubs\n */'
VERSION="19"

RUNFROM=$PWD
DEST="${RUNFROM}/dolibarr-${VERSION}"

set -e

# test -f "$FILE"
test -d "source/dolibarr"

# Exclude globals.
(
    cd source/dolibarr/htdocs
    for fic in `find . -type f -name "*.php"`
    do
        if [ -f "${fic}" ]; then
            echo "run for ${fic} ..."
            # --finder=finder.php \
            #--header="$HEADER" \
            ${RUNFROM}/vendor/bin/generate-stubs \
                ${fic} \
                --include-inaccessible-class-nodes \
                --force \
                --functions \
                --classes \
                --interfaces \
                --traits \
                --constants \
                --documented-globals \
                --quiet \
                --out="${DEST}/${fic}.php"
        fi
    done

    #cleanup "empty" files
    find "${DEST}" -type f -size 7c -exec rm {} \;
    #remove empty dirs
    find "${DEST}" -type d -exec rmdir {} \;
)

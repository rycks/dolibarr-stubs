#!/usr/bin/env bash
#
# Generate Dolibarr stubs from all the latest versions.
#
# Watch current release on Packagist.

set -e

WC_JSON="$(wget -q -O- "https://api.github.com/repos/dolibarr/dolibarr/tags")"

for V in 18.0 17.0 16.0 15.0 14.0; do
    # Find latest version
    printf -v JQ_FILTER '.[].name'
    LATEST="$(jq -r "$JQ_FILTER" <<<"$WC_JSON" | grep ${V} | sort -t "." -k 3 -g | tail -n 1)"
    if [ -z "$LATEST" ]; then
        echo "No version for ${V}!"
        continue
    fi
    MAINVER=`echo ${LATEST} | cut -d'.' -f1-2`

    echo "Releasing version ${LATEST} (main version is ${MAINVER})..."

    if [ -f stubs/dolibarr-stubs-${MAINVER}.php ]; then
        echo "stub file exists for that main version, next"
        continue
    fi

    # if git rev-parse "refs/tags/v${LATEST}" >/dev/null 2>&1; then
    #     echo "Tag exists!"
    #     continue
    # fi

    # Clean up source/ directory
    # git status --ignored --short -- source/ | sed -n -e 's#^!! ##p' | xargs --no-run-if-empty -- rm -rf
    # Get new version
    # printf -v SED_EXP 's#\\("dolibarr/dolibarr"\\): "[0-9]\\+\\.[0-9]\\+\\.[0-9]\\+"#\\1: "%s"#' "${LATEST}"
    # sed -i -e "$SED_EXP" source/composer.json
    #composer run-script post-install-cmd
    rm -rf source/dolibarr
    wget -P source/ "https://github.com/Dolibarr/dolibarr/archive/refs/tags/${LATEST}.zip"
    unzip -q -d source/ source/${LATEST}.zip
    mv source/dolibarr-${LATEST} source/dolibarr

    # Generate stubs
    echo "Generating stubs ..."

    ./generate.sh
    mv dolibarr-stubs.php stubs/dolibarr-stubs-${MAINVER}.php

    # clean up
    rm -rf source/dolibarr
    rm -f source/${LATEST}.zip


    # Tag version
    # git commit --all -m "Generate stubs for Dolibarr ${LATEST}"
    # git tag "v${LATEST}"
done

#!/bin/bash
set -e

function main {
    PROJECTS="$@"
    if [ "${PROJECTS}" = "" ]; then
        PROJECTS=$(find . -type f -name Dockerfile | sed -r 's|/[^/]+$||' | sed -r 's|./||' | sort -u)
    fi

    for project in $PROJECTS; do
        docker build --tag lizards/$project --file $project/Dockerfile .
    done
}

main $@

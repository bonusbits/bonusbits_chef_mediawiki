#!/usr/bin/env bash

function usage () {
usagemessage="
usage: $0 -t [tagname]

-t Tag Name to Set as latest     :  (Required)
"
    echo "$usagemessage";
}

# Argument Parser
while getopts "t:" opts; do
    case $opts in
        t ) tag=$OPTARG;;
    esac
done

# Bail if Missing Tag Name
if [ -z $tag ]; then
    usage
    echo "ERROR: Release Tag Name Missing!"
    exit 1
fi

git pull
git tag -d latest
git push origin :refs/tags/latest
git checkout ${tag}
git tag -af latest -m "${tag} Release"
git push origin --tags
git checkout master

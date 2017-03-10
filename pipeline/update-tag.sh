#!/usr/bin/env bash

default_newtag="latest"
script_version="v1.1.0"

function usage () {
usagemessage="
Usage: $0 -r [release_tag_name] -n [new_tag_name]

Options:
    -r Release Tag Name               :  (Required) i.e. v1.0.0
    -n New Tag Name to add/replace    :  (Optional) i.e. latest, rc, dev, or beta. (Defaults to 'latest')
"
    echo "$usagemessage";
}

function version_message() {
versionmessage="Update Latest Tag Version: $script_version"
    echo "$versionmessage";
}

# Argument Parser
while getopts "r:n:vh" opts; do
    case $opts in
        r ) release=$OPTARG;;
        n ) newtag=$OPTARG;;
        v ) version_message; exit 0;;
        h ) usage; exit 0;;
    esac
done

# Bail if Missing Tag Name
if [ -z $release ]; then
    usage
    echo "ERROR: Release Tag Name Missing!"
    exit 1
fi
if [ -z $newtag ]; then newtag=$default_newtag; fi

git pull
git tag -d ${newtag}
git push origin :refs/tags/${newtag}
git checkout ${release}
git tag -af ${newtag} -m "$release Release"
git push origin --tags
git checkout master

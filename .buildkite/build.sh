#! /usr/bin/env bash

# Could move this type of setup to hooks
if [[ $LE_TRIGGERED_FROM_BUILD_ID ]]
then
  echo "--- Downloading debian package from Buildkite"
  buildkite-agent artifact download --build $LE_TRIGGERED_FROM_BUILD_ID 'dist/*.deb' .
else
  echo "Image will use Debian Package from Launchpad"
fi

echo "--- Building Pi Image"
PRESERVE_CONTAINER=1 
CONTINUE=1 
. ./build-docker.sh

echo "--- Uploading artifacts"

# Moving to another folder to match convention of other installers
mv deploy dist

if [[ $LE_TRIGGERED_FROM_JOB_ID ]]
then
  buildkite-agent artifact upload dist/*.zip --job $LE_TRIGGERED_FROM_JOB_ID
fi

# Upload twice - once to pipeline, and once to this one
buildkite-agent artifact upload dist/*.zip